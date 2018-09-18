(*
Merge Sort Algorithm implemented in Apple Script

Author: Carlos Abraham Hernandez (abraham@abranhe.com)

Parameters: (list, range index 1, range index 2)
*)

on mergeSort(theList, l, r) -- Sort items l thru r of theList.
	script o
		property lst : theList
		property auxList : missing value
		
		on msrt(l, r)
			set leftR to (l + r) div 2 -- Left half end index.
			set rx to leftR + 1 -- Right half start/tracking index.
			
			-- Sort the left half by recursion if it has more than two items or by swapping as necessary if there are two. If one, do nothing.
			if (leftR - l > 1) then
				msrt(l, leftR)
			else if (leftR > l) then
				set lv to item l of my lst
				set rv to item leftR of my lst
				if (rv < lv) then
					set item l of my lst to rv
					set item leftR of my lst to lv
				end if
			end if
			-- Sort the right half similarly.
			if (r - rx > 1) then
				msrt(rx, r)
			else if (r > rx) then
				set lv to item rx of my lst
				set rv to item r of my lst
				if (rv < lv) then
					set item rx of my lst to rv
					set item r of my lst to lv
				end if
			end if
			
			-- Extract a separate list of the left half's items and set tracking and end indices for it.
			set auxList to items l thru leftR of my lst
			set lx to 1
			set leftR to rx - l
			
			-- Iterate through the range, merging the two halves by comparing the lowest unassigned value from auxList with that from the right half of the range and assigning the lower of the two (or the left if they're equal) to the current slot.
			
			-- Begin with the first (lowest) value from each half.
			set lv to beginning of my auxList
			set rv to item rx of my lst
			repeat with dx from l to r
				if (rv < lv) then
					-- The right value's less than the left. Assign it to this slot.
					set item dx of my lst to rv
					-- If no more right-half values, assign the remaining left values to the remaining slots and exit this repeat and recursion level.
					if (rx is r) then
						repeat with dx from (dx + 1) to r
							set item dx of my lst to item lx of my auxList
							set lx to lx + 1
						end repeat
						exit repeat
					end if
					-- Otherwise get the next right-half value.
					set rx to rx + 1
					set rv to item rx of my lst
				else
					-- The left value's less than or equal to the right.
					set item dx of my lst to lv
					-- If no more left-half values, simply exit this repeat and recursion level as the remaining right values are in place anyway.
					if (lx is leftR) then exit repeat
					-- Otherwise get the next left-half value
					set lx to lx + 1
					set lv to item lx of my auxList
				end if
			end repeat
		end msrt
	end script
	
	-- Process the input parameters.
	set listLen to (count theList)
	if (listLen > 1) then
		-- Negative and/or transposed range indices.
		if (l < 0) then set l to listLen + l + 1
		if (r < 0) then set r to listLen + r + 1
		if (l > r) then set {l, r} to {r, l}
		
		-- Do the sort.
		o's msrt(l, r)
	end if
	
	return -- nothing
end mergeSort

property sort : mergeSort

-- (* Demo:
set l to {}
repeat 100 times
	set end of my l to (random number 100)
end repeat

sort(l, 1, -1)
l
-- *)
