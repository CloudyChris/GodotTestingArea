#MIT License

#Copyright (c) 2023 Xavier Sellier

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

class_name UUID
extends Resource

const BYTE_MASK: int = 0b11111111

var myUUID : Array
@export var myUUID_stringified : String

static func uuidbin():
	randomize()
	# 16 random bytes with the bytes on index 6 and 8 modified
	return [
	randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK,
	randi() & BYTE_MASK, randi() & BYTE_MASK, ((randi() & BYTE_MASK) & 0x0f) | 0x40, randi() & BYTE_MASK,
	((randi() & BYTE_MASK) & 0x3f) | 0x80, randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK,
	randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK,
	]

static func uuidbinrng(rng: RandomNumberGenerator):
	rng.randomize()
	return [
	rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK,
	rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK, ((rng.randi() & BYTE_MASK) & 0x0f) | 0x40, rng.randi() & BYTE_MASK,
	((rng.randi() & BYTE_MASK) & 0x3f) | 0x80, rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK,
	rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK, rng.randi() & BYTE_MASK,
	]

func _init() -> void:
	myUUID = uuidbin()
	myUUID_stringified = as_string()

func as_string() -> String:
	return '%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x' % [
	# low
	myUUID[0], myUUID[1], myUUID[2], myUUID[3],

	# mid
	myUUID[4], myUUID[5],

	# hi
	myUUID[6], myUUID[7],

	# clock
	myUUID[8], myUUID[9],

	# node
	myUUID[10], myUUID[11], myUUID[12], myUUID[13], myUUID[14], myUUID[15]
	]

func as_array() -> Array:
	return myUUID.duplicate()

func is_equal(other: UUID) -> bool:
	# Godot Engine compares Array recursively
	# There's no need for custom comparison here.
	return myUUID == other.myUUID

func as_dict(big_endian := true) -> Dictionary:
	if big_endian:
		return {
		"low"    	: (myUUID[0]    	<< 24) + 	(myUUID[1]    << 16) + (myUUID[2]    << 8 ) +    myUUID[3],
		"mid"    	: (myUUID[4]    	<< 8 ) +    myUUID[5],
		"hi"     	: (myUUID[6]    	<< 8 ) +    myUUID[7],
		"clock"		: (myUUID[8]    	<< 8 ) +    myUUID[9],
		"node" 		: (myUUID[10] 	<< 40) + 	(myUUID[11] << 32) + (myUUID[12] << 24) + (myUUID[13] << 16) + (myUUID[14] << 8 ) +    myUUID[15]
	}
	else:
		return {
		"low"    	: myUUID[0]                    	+ (myUUID[1]    << 8 ) + (myUUID[2]    << 16) + (myUUID[3]    << 24),
		"mid"    	: myUUID[4]                    	+ (myUUID[5]    << 8 ),
		"hi"     	: myUUID[6]                    	+ (myUUID[7]    << 8 ),
		"clock"		: myUUID[8]                    	+ (myUUID[9]    << 8 ),
		"node" 		: myUUID[10]                 	+ (myUUID[11] << 8 ) + (myUUID[12] << 16) + (myUUID[13] << 24) + (myUUID[14] << 32) + (myUUID[15] << 40)
	}
