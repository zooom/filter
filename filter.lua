--	┌──────────────┐ --
--	│              │ --		Author:    Ashok Menon, Markus Müller
--	│    FILTER    │ --		Date:      April 25th, 2012
--	│              │ --		Version:   1.1
--	└──────────────┘ --

	local class = {}

--	┌───────────────────────────────────────────────────────────────────────────────────────────────
--	│ USAGE
--	└───────────────────────────────────────────────────────────────────────────────────────────────

--		1. Import the module
--		--------------------
--		local filter = require 'filter'


--		2. Call the deploy() method as a property of physics.addBody()
--		--------------------------------------------------------------
--		filter:deploy( { properties }, category, { targets } )

--	┌───────────────────────────────────────────────────────────────────────────────────────────────
--	│ METHODS
--	└───────────────────────────────────────────────────────────────────────────────────────────────

	--	Constructor
	------------------------------------------------------------------------------------------------

		function class:deploy( properties, category, targets )

		--	Create a new filter

			local filter = {

				categoryBits = self:getBitsForCategory( category ),
				maskBits = self:getBitsForTargets( targets )

			}

		--	Append the filter to properties

			properties.filter = filter

			return properties

		end

	--	Trace
	------------------------------------------------------------------------------------------------

		function class:trace( group, bit, counter )

			print( 'group    =  ' .. group )
			print( 'bit      =  ' .. bit )
			print( 'counter  =  ' .. counter )
			print( '-----------------------' )

		end

	--	Bits
	------------------------------------------------------------------------------------------------

		function class:createBit( group )

		--	Check, if a bit for the group already exists

			if self.bits[ group ] ~= nil then

				return

			end
			
		--	Create a unique bit for the group, based on the amount of groups
    
			self.bits[ group ] = 2 ^ self.counter
			self.counter = 1 + self.counter

		--	Trace the variables

			self:trace( group, self.bits[ group ], self.counter )

		end

	--	Getter :: categoryBits
	------------------------------------------------------------------------------------------------

		function class:getBitsForCategory( category )

			self:createBit( category )
			
			return self.bits[ category ]

		end

	--	Getter :: maskBits
	------------------------------------------------------------------------------------------------

		function class:getBitsForTargets( targets )
    
			local maskBits = 0

			for key, value in ipairs( targets ) do

				self:createBit( value )
				maskBits = maskBits + self.bits[ value ]

			end

			return maskBits

		end

--	┌───────────────────────────────────────────────────────────────────────────────────────────────
--	│ INITIALIZATION
--	└───────────────────────────────────────────────────────────────────────────────────────────────

		class.bits = {}			-- Created bits for groups
		class.counter = 0		-- Amount of groups in total

	return class

