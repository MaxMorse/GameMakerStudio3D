/// @function AddVectors2D(v1, v2)
/// @description Adds two 2D Vectors together and returns sum
/// @param v1 first 2D Vector (array of length two) to add
/// @param v2 second 2D Vector (array of length two) to add
function AddVectors2D(v1, v2)
{
	return [v1[0] + v2[0], v1[1] + v2[1] ];	
}
/// @function VectorFromTo2D(from, to)
/// @description Returns the Vector between two 2D points
/// @param from 2D Vector (array of length two) to start from
/// @param to 2D Vector (array of length two) representing destination
function VectorFromTo2D(from, to)
{
	return [to[0] - from[0],to[1] - from[1]]
}

/// @function VectorMagnitude2D
/// @description Returns the magnitude of a 2D Vector
/// @param vector 2D Vector (array of length two) to calculate magnitude
function VectorMagnitude2D(vector)
{
	return sqrt(sqr(vector[0]) + sqr(vector[1]))	
}

/// @function MoveInstanceTo2D(pos, instance)
/// @description Moves an instance to a specified position in 2D world space
/// @param pos 2D point (array of length two) in world space coordinates to move a gameobject to instantly
/// @param instance Gameobject instance to move
function MoveInstanceTo2D(pos, instance)
{
	var sPos = WorldToScreenVector(pos);
	instance.x = sPos[0];
	instance.y = sPos[1];
}
/// @function WorldToScreenVevtor(worldpoint)
/// @description Takes a point in 2D world space and converts to screen coordinates
/// @param worldpoint 2D point (array of length 2) in worldspace coordinates
function WorldToScreenVector(worldPoint)
{
	return [global.origin[0] + worldPoint[0] * global.unit, global.origin[1] + -worldPoint[1] * global.unit]
}

function ScreenToWorldVector(screenPoint)
{
	return [(screenPoint[0] - global.origin[0]) / global.unit,
	-(screenPoint[1] - global.origin[1]) / global.unit];
}

function SpawnObject(pos, obj)
{
	var sPoint = WorldToScreenVector(pos)
	return instance_create_layer(sPoint[0], sPoint[1],"Instances", obj);
	
}
function MultiplyVector(vector, scalar)
{
	return [vector[0] * scalar, vector[1] * scalar]		
}
function NormalizedVector(vector)
{
	var len = VectorMagnitude2D(vector);
	return MultiplyVector(vector, 1/len); 	
}
function CrossProduct2D(vector1, vector2)
{
		
}
function DrawVector(origin, vector)
{
	var p1 = WorldToScreenVector(origin);
	var p2 = WorldToScreenVector(AddVectors2D(origin, vector));
	draw_arrow(p1[0], p1[1], p2[0], p2[1],10);		
}

function DrawCircle(center, radius, outline)
{
	var c = WorldToScreenVector(center);
	draw_circle(c[0], c[1], radius, outline);
}
