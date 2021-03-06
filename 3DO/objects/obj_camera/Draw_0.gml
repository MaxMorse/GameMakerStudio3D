
#region camera update
//var clearColor = make_color_hsv(.7778, .6, 1)
if(active)
{
	draw_clear(c_ltgrey);
	var camera = camera_get_active();

	//var lookFrom = [x,y, depth];
	//t xPos = Mathf.Sin(transform.eulerAngles.y * Mathf.Deg2Rad) * Mathf.Cos(transform.eulerAngles.x * Mathf.Deg2Rad);
	//        float yPos = Mathf.Sin(-transform.eulerAngles.x * Mathf.Deg2Rad);
	  //      float zPos = Mathf.Cos(transform.eulerAngles.x * Mathf.Deg2Rad) * Mathf.Cos(transform.eulerAngles.y * Mathf.Deg2Rad);
 
	//var lookFrom = [x, y, depth]; 


	//lookAt = [lookFrom[0] + forward[0], lookFrom[1] + forward[1], lookFrom[2] + forward[2]]
	/*if(target != -1)
	{
		lookFrom[0] = target.x;
		lookFrom[1] = target.y;
		lookFrom[2] = target.depth;

		lookAt[0] = target.x + dcos(target.look_dir);
		lookAt[1] = target.y - dsin(target.look_pitch);
		lookAt[2] = target.depth - dsin(target.look_dir);
	}*/
	var camUp = [0, 0, -1];

	var fpLookAt = matrix_build_lookat(lookFrom[0], lookFrom[1], lookFrom[2], lookAt[0], lookAt[1], lookAt[2], camUp[0], camUp[1], camUp[2]);
	//var viewMatrix = 
	var projMatrix = undefined; matrix_build_projection_ortho(1280, 720, 1, 1000000);
	switch (mode) {
	    case CameraMode.Projection:
	        projMatrix = matrix_build_projection_perspective_fov(60, window_get_width()/ window_get_height(), 1, 32000 );
	        break;
	    case CameraMode.Orthographic:
	        projMatrix = matrix_build_projection_ortho(window_get_width(), window_get_height(), 1, 32000);
	        break;
	}

	camera_set_view_mat(camera, fpLookAt);
	camera_set_proj_mat(camera, projMatrix );
	//camera_set_or
	camera_apply(camera);
	#endregion

	#region render skybox
	
	gpu_set_zwriteenable(false);
	matrix_set(matrix_world, matrix_build(0, 0, 0, 0,0,0, 100, 100, 100));
	vertex_submit(skybox, pr_trianglelist,sprite_get_texture(spr_skybox, 0));
	//vertex_submit(bkg, pr_trianglelist, -1);
	matrix_set(matrix_world, matrix_build_identity());
	gpu_set_zwriteenable(true);

	#endregion


	#region render game objects
	if (renderGrid) vertex_submit(grid, pr_trianglelist, -1);
	if (renderWireFrameGrid) vertex_submit(wireGrid, pr_linelist, -1);
	if (renderGizmo) vertex_submit(gizmo, pr_linelist, -1);
	with(oGameObject) 
	{
		if(object_index != obj_camera)
		{
			
			event_perform(ev_draw, 0);
		}
	}
}
#endregion