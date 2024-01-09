-- SplitByMats 0.0.1
-- (c) 2024 Mike Oxmaul
-- https://github.com/oxmaulmike2581
-- Licensed under MIT License - https://opensource.org/license/mit/

macroScript SplitByMats
category:"Scripts by Mike"
buttonText:"SplitByMats"
--toolTip:"Split all objects by their materials"
silentErrors:true
(
	-- Perform a detach with original normals
	-- NOTE: original code of this function was copied from detach_script.ms and slightly modified by me
	fn detachFunc o f n = 
	(
		-- get original wire color
		wc = o.wirecolor
		
		-- copy original object
		c = copy o
		
		-- delete unneccessary faces from source object
		polyop.deleteFaces o f
		
		-- ...and from copied object
		polyop.deleteFaces c -f
		
		-- clear face selection
		polyop.setFaceSelection c #{}
		
		-- set the same wire color as on original object to the copied one
		c.wirecolor = wc
		
		-- set the new name to the copied object
		c.name = n
	)
	
	-- Prepare all needed data to detach
	fn prepare o i mn = 
	(
		-- select faces by material id
		o.selectbymaterial i
		
		-- get selected face ID's as Array
		local objFaces = polyOp.getFaceSelection o
		
		-- build a new name for the object
		local newName = (o.name + "_" + mn) as string
		
		-- go to the next step
		detachFunc o objFaces newName
	)

	fn mainWork obj = 
	(
		-- Only work with non-empty objects
		if (getNumFaces obj > 0) do
		(
			-- Only work with objects which have materials
			if (obj.material != undefined) then
			(
				-- Get material ID's array
				local ids = obj.material.materialIDList
				
				-- Only work if it's not empty (it can be in case of using Multi-Sub Objects)
				if (ids.count > 0) then
				(
					if (ids.count > 1) then
					(
						-- Loop through MSO
						for id in ids do
						(
							-- Embedded Multi-Sub Object detected, so we need to loop through it first
							if (matchpattern obj.material[id].name pattern:"*_mso" ignoreCase:true) then
							(
								local mmids = obj.material[id].materialIDList
								for mmid in mmids do
								(
									-- get proper material name
									local a = obj.material[id][mmid].name
									
									-- goto to next step
									prepare obj mmid a
								)
							)
							else
							(
								local b = obj.material[id].name
								prepare obj id b
							)
						)
					)
					else
					(
						print("obj has 1 mat")
					)
				)
			)
			else
			(
				print("[WARNING] Object \"" + (obj.name as string) + "\" does not have materials.")
			)
		)
	)
	
	-- Main function
	on execute do
	(
		-- Select all geometry objects in the scene
		select (for o in geometry collect o)
		
		local sceneObjs = #()
		append sceneObjs $
		
		-- Check for empty scene
		if (sceneObjs.count < 1) then
		(
			messageBox "Can't find any object that I can work with. Is your scene empty?" title:"Error"
		)
		else
		(
			-- Loop through all selected objects
			for obj in sceneObjs do
			(
				-- If the object was not converted to Editable Poly - try to convert it and then process
				-- Otherwise process it immediately
				if (not isKindOf obj Editable_Poly) then
				(
					macros.run "Modifier Stack" "Convert_to_Poly"
					mainWork obj
				)
				else
				(
					mainWork obj
				)
			)
		)
	)
)

