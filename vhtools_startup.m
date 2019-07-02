function vhtools_startup(toolsprefix, verbose);

% VHTOOLS_STARTUP - Include paths and initialize variables for VHLAB_VHTOOLS
%
%  VHTOOLS_STARTUP([TOOLSPREFIX, VERBOSE])
%
%  Initializes tools written by Steve Van Hooser and others 1999-2017.
%
%  TOOLSPREFIX should be the directory where the user toolbox directories reside.
%  If it is not provided, then the function searches for its own path using
%  WHICH. In that case, the TOOLSPREFIX is taken to be 1 directory 'above' the 
%  directory that contains the .m file for VHTOOLS_STARTUP.
%
%  If VERBOSE is not specified or is 1, then each library is installed with a
%  startup message like 'Initializing NewStim library'
%
%  Each subdirectory of TOOLSPREFIX is searched for a file that ends in 'Init.m'.
%  If such a file is located, then it is run to initialize the directory.
%
%  Normally, the user sets up this file so it is automatically run by the user's
%  startup.m file.
%
%  See also:  MATLABRC
%

if nargin<1,
	myfilepath = which('vhtools_startup');
	pi = find(myfilepath==filesep);
	toolsprefix = [myfilepath(1:pi(end-1)-1) filesep];
end;

if nargin>1, vb = verbose; else, vb = 1; end;

% step 1: remove existing paths if necesary
pathstr = pathstr2cellarray_vhs;
matches = strfind(pathstr,'vhlab');
inds = find(1-isempty_cell_vhs(matches));
if ~isempty(inds),
	if vb, 
		disp(['Note: removing ' int2str(length(inds)) ' directories that contain vhlab from the path.']);
	end;
	rmpath(pathstr{inds});
end;


% step 2: add paths

if vb,
	disp(['Adding ' toolsprefix ' and all subdirectories to the path']);
end;
addpath(genpath(toolsprefix));

  % remove 'archived_code' paths if necesary
pathstr = pathstr2cellarray_vhs;
matches = strfind(pathstr,'archived_code');
inds = find(1-isempty_cell_vhs(matches));
if ~isempty(inds),
        if vb,
                disp(['Note: removing ' int2str(length(inds)) ' directories that contain the string ''archived_code'' from the path.']);
        end;
        rmpath(pathstr{inds});
end;
  % remove '.git' paths if necesary
pathstr = pathstr2cellarray_vhs;
matches = strfind(pathstr,'.git');
inds = find(1-isempty_cell_vhs(matches));
if ~isempty(inds),
        if vb,
                disp(['Note: removing ' int2str(length(inds)) ' directories that contain the string ''.git'' from the path (git hidden files).']);
        end;
        rmpath(pathstr{inds});
end;

% step 3: look for a BLAHBLAHInit.m file; if it is there, run it

d = dir(toolsprefix);
dirnames = dirlist_trimdots(d); % in step 2 we get vhlab_mltbx_toolbox, where this function lives

for d=1:length(dirnames),
	files = dir([toolsprefix filesep dirnames{d} filesep '*Init.m']);
	for f=1:length(files),
        [parent,fname,ext]=fileparts(files(f).name);
		if vb, disp(['Initializing ' dirnames{d} '...']); end;
		eval(fname);
	end;
end;

vhtools_start

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function path_cellstr = pathstr2cellarray_vhs  % embedded function 
pathstr = path;
sep = pathsep;

inds = [0 find(pathstr==sep)];

if inds(end)~=length(pathstr),  % make sure the last point is the point we wish to copy until
        inds(end+1) = length(pathstr)+1;
end;

path_cellstr = {};

for i=1:length(inds)-1,
        path_cellstr{i} = pathstr(inds(i)+1:inds(i+1)-1);
end;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function b = isempty_cell_vhs(thecell) % embedded function
b = zeros(size(thecell));

for i=1:length(b(:)),
        b(i) = isempty(thecell{i});
end;
