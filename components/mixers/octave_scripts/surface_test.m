%[x, y, z] = meshgrid (1:5, 1:5, 1:5);
%v = rand (5, 5, 5);
%isosurface (x*1e9, y*1e9, z*1e9, v, .5, "EdgeColor",[0.5 0.5 0.5 0.5]);

%[x, y, z] = meshgrid(if_axis,lo_axis, rf_axis);
%isosurface(x, y, z, dat, -40);