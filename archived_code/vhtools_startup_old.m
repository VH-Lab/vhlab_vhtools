function vhtools_startup(toolsprefix, verbose);

% VHTOOLS_STARTUP - Include paths and initialize variables for VHTOOLS
%
%  VHTOOLS_STARTUP(TOOLSPREFIX, [, VERBOSE])
%
%  Initializes tools written by Steve Van Hooser and others 1999-2017.
%
%  TOOLSPREFIX should be the directory where the tool directories reside.
%
%  If VERBOSE is present and is 1, then each library is installed with a
%  startup message like 'Initializing NewStim library'
%
%  Normally, the user sets up this file so it is automatically run by the user's
%  startup.m file.
%
%  See also:  MATLABRC
%

if nargin==0,
	error(['Not enough input arguments to vhtools_startup. If you are looking for the vhtools_start menu please remember to use vhtools_start instead of vhtools_startup.']);
end;

if nargin>1, vb = verbose; else, vb = 0; end;

  % remove existing paths if necesary
pathstr = pathstr2cellarray_vhs;
matches = strfind(pathstr,'vhlab');
inds = find(1-isempty_cell_vhs(matches));
if ~isempty(inds),
	if vb, 
		disp(['Note: removing ' int2str(length(inds)) ' directories that contain vhlab from the path.']);
	end;
	rmpath(pathstr{inds});
end;

localdirprefix = fileparts(toolsprefix);

if toolsprefix(end)~=filesep,
    toolsprefix = [toolsprefix filesep];
end;
if localdirprefix(end)~=filesep,
    localdirprefix = [localdirprefix filesep];
end;
library_prefix = [toolsprefix 'libraries' filesep'];

thirdparty_prefix = [localdirprefix '..' filesep 'vhtools_thirdparty'];

currPath = pwd;

addpath(toolsprefix);

if vb, disp(['Initializing vhtools using directory ' localdirprefix '....']); end;

if 1, % some calibration files for the packages that depend on each computer
		if exist([localdirprefix 'calibration'])==7,
			addpath([localdirprefix 'calibration']);
		end;
end;

if 1, % some configuration files for the packages that depend on each computer
		addpath([localdirprefix 'configuration']); % default values
end;

if 1, % some generally useful tools not associated with any particular package
	addpath(genpath([toolsprefix 'toolbox']));
	if vb, disp(['Initializing toolboxes VH_matlab_code' filesep 'toolbox' ]); end;
end;

if 1, % some generally useful tools for neuroscience not associated with any particular package
	addpath(genpath([toolsprefix 'neuroscience']));
	if vb, disp(['Initializing library VH_matlab_code' filesep 'neuroscience']); end;
end;

if 1&exist([thirdparty_prefix])==7, % initialize 3rd party tools
	addpath(thirdparty_prefix);
	vhtools_thirdparty_startup([thirdparty_prefix],1);
end;

if 1&exist([thirdparty_prefix])==7, % add matlab_functions 
	addpath(genpath([thirdparty_prefix filesep 'matlab_functions']));
end;

if 1, % published and unpublished data
	addpath(genpath([toolsprefix 'vhlab_publishedstudies']));
	addpath(genpath([toolsprefix 'vhlab_unpublishedstudies']));
end;

if 1,   % Legacy code
        ATp = [ library_prefix 'legacy_code' filesep];
        addpath(genpath(ATp));
	if vb, disp(['Initializing library VH_matlab_code' filesep 'libraries' filesep 'legacy_code']); end;
end;


if 1,   % AnalysisTools
        ATp = [ library_prefix 'AnalysisTools' filesep];
        addpath(genpath(ATp));
        measureddata([1 2],'','');
        spikedata([1 2],'','');
	if vb, disp(['Initializing library VH_matlab_code' filesep 'libraries' filesep 'AnalysisTools']); end;
end;


if 1,   % NewStim package
        addpath([library_prefix 'NewStim']);        
	if vb, disp(['Initializing library VH_matlab_code' filesep 'libraries' filesep 'NewStim']); end;
        NewStimInit
end;

if 1,   % SpikeDataExtraction
        DTp = [ library_prefix 'SpikeDataExtraction' filesep];
        addpath(genpath(DTp));
	if vb, disp(['Initializing library VH_matlab_code' filesep 'libraries' filesep 'SpikeDataExtraction']); end;
end;

if 1,   % StimulusDecoding
        DTp = [ library_prefix 'StimulusDecoding' filesep];
        addpath(genpath(DTp));
	if vb, disp(['Initializing library VH_matlab_code' filesep 'libraries' filesep 'StimulusDecoding']); end;
end;


if 1, % apps program and tools
	appsPath = [ toolsprefix 'apps' filesep ];
	addpath(genpath(appsPath));
	if vb, disp(['Initializing library VH_matlab_code' filesep 'apps']); end;
        NelsonLabToolsInit;
	VHLabToolsInit;
        TwoPhotonInit;
end;


if 1, % add studies
	addpath(genpath([toolsprefix 'studies']));
	if vb, disp(['Initializing library VH_matlab_code' filesep 'studies']); end;
	FitzLabInit;
end;


if 1,   % Psychophysics toolbox
	if strcmp(computer,'MAC'),
        	PsychoPath=[toolsprefix 'Psychtbox_X' filesep ...
				'Psychtoolbox' filesep];
		addpath([PsychoPath 'PsychAlpha']);
		addpath([PsychoPath 'PsychAlphaBlending']);
		addpath([PsychoPath 'PsychBeta']);
		addpath([PsychoPath 'PsychBasic']);
		addpath([PsychoPath 'PsychContributed']);
		addpath([PsychoPath 'PsychDemos']);
		addpath([PsychoPath 'PsychFiles']);
		addpath([PsychoPath 'PsychHardware']);
		addpath([PsychoPath 'PsychHardware' filesep 'Daq']);
		addpath([PsychoPath 'PsychInitialize']);
		addpath([PsychoPath 'PsychObsolete']);
		addpath([PsychoPath 'PsychOneliners']);
		addpath([PsychoPath 'PsychPriority']);
		addpath([PsychoPath 'PsychProbability']);
		addpath([PsychoPath 'PsychRects']);
		addpath([PsychoPath 'PsychTests']);
		addpath([PsychoPath 'Quest']);
    elseif ~isunix&~ispc,
       		PsychoPath=[toolsprefix 'PsychToolbox' filesep];
	        addpath([PsychoPath 'PsychBasic']);
		addpath([PsychoPath 'PsychCal']);
	        addpath([PsychoPath 'PsychCalData']);
		addpath([PsychoPath 'PsychClipboard']);
		addpath([PsychoPath 'PsychColorimetric']);
		addpath([PsychoPath 'PsychColorimetricData']);
		addpath([PsychoPath 'PsychContributed']);
		addpath([PsychoPath 'PsychDemos']);
		addpath([PsychoPath 'PsychFiles']);
		addpath([PsychoPath 'PsychGamma']);
	        addpath([PsychoPath 'PsychHardware']);
	        addpath([PsychoPath 'PsychHardware' filesep 'Daq']);
	        addpath([PsychoPath 'PsychMATLABTests']);
	        addpath([PsychoPath 'PsychObsolete']);
	        addpath([PsychoPath 'PsychOneliners']);
	        addpath([PsychoPath 'PsychOptics']);
	        addpath([PsychoPath 'PsychProbability']);
	        addpath([PsychoPath 'PsychQuest']);
	        addpath([PsychoPath 'PsychRects']);
	        addpath([PsychoPath 'PsychScripts']);
	        addpath([PsychoPath 'PsychSignal']);
	        addpath([PsychoPath 'PsychTests']);
	        addpath([PsychoPath 'Psychometric']);
	end;
end;

  % remove existing paths if necesary
pathstr = pathstr2cellarray_vhs;
matches = strfind(pathstr,'archived_code');
inds = find(1-isempty_cell_vhs(matches));
if ~isempty(inds),
        if vb,
                disp(['Note: removing ' int2str(length(inds)) ' directories that contain the string ''archived_code'' from the path.']);
        end;
        rmpath(pathstr{inds});
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
