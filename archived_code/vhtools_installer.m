function vhtools_installer(command, thefig)
% VHTOOLS_INSTALLER - Install the VH lab tools packages -- very depricated
%
%  VHTOOLS_INSTALLER
%
%  This program is used to install software for the 
%  Van Hooser lab and its collaborators.
%
%  Documentation for the package can be found at
%  http://sites.google.com/site/vhlabtools
%
%  To install, most users can select the default
%  options, choose the directory where they want
%  to install the tools, and click Install/Update.
%
%  Troubleshooting:
%      If you install Bazaar while Matlab is still running,
%      you should quit and restart Matlab so Matlab will know
%      where to find Bazaar.
%
%      If you get an error that says "unable to obtain lock"
%      on a particular file, then you'll have to delete the
%      entire directory (vhtools or vhtools_thirdparty) and
%      re-install.  This usually occurs when there is an error
%      during installation, such as if a previous install was
%      quit while in progress.
%
%      If you get an error on Windows that says
%      "unable to authenticate to SSH host" and you are confident
%      you have the username and password correct, simply try again
%      a few times.  For unknown reasons, there seems to be some issue
%      with the version of SSH that comes with Bazaar.
%  

errordlg(['This program is out of date and should no longer be used.']);
error(['This program is out of date and should no longer be used.']);


if nargin==0,
	command = 'NewWindow';
	fig = figure;
end;

if nargin==2,  % then is command w/ fig as 2nd arg
    fig = thefig;
    ud = get(fig,'userdata');
end;

if ~isa(command,'char'),
    % if not a string, then command is a callback object
    command = get(command,'Tag');
    fig = gcbf;

    ud = get(fig,'userdata');
end;

 % at this point:
 %   fig - the figure that corresponds to the installer
 %   ud - userdata of the current figure
 %   

command, 

switch command,
	case 'NewWindow',

		% Step 1 - Make sure we have bazarr installed and we can run it

		try,
			vhtools_installer('CheckBzr',fig);
		catch,
			close(fig);
			error(['An error occurred while trying to set up the installation.']);
		end;

		% Step 2 - build the window

		button.Units = 'pixels';
		button.BackgroundColor = [0.8 0.8 0.8];
		button.HorizontalAlignment = 'center';
		button.Callback = 'eval([get(gcbf,''Tag'') ''(gcbo);'']);';
		txt.Units = 'pixels'; txt.BackgroundColor = [0.8 0.8 0.8];
		txt.fontsize = 12; txt.fontweight = 'normal';
		txt.HorizontalAlignment = 'left';txt.Style='text';
		edit = txt; edit.BackgroundColor = [ 1 1 1]; edit.Style = 'Edit';
		popup = txt; popup.style = 'popupmenu';
		popup.Callback = 'eval([get(gcbf,''Tag'') ''(gcbo);'']);';
		cb = txt; cb.Style = 'Checkbox';
		cb.Callback = 'eval([get(gcbf,''Tag'') ''(gcbo);'']);';
		cb.fontsize = 12;

		set(fig,'position',[50 50 700 500],'tag','vhtools_installer');

		row = 35;
		top = 450;

		uicontrol(txt,'position',[5 top 200 30],'string','Install/update vhtools','fontweight','bold');
		uicontrol(txt,'position',[5 top-row*1 600 30],'string','1: Where will you obtain files to install? (most will choose defaults)','fontweight','bold');

		uicontrol(txt,'position',[5 top-row*2 100 30],'string','Server');
		uicontrol(popup,'position',[5+100+5 top-row*2 250 30],'tag','ServerPopup');
		uicontrol(edit,'position',[5+100+5+250+5 top-row*2 250 30],'tag','ServerOtherEdit');

		uicontrol(txt,'position',[5 top-row*3 100 30],'string','Username');
		uicontrol(popup,'position',[5+100+5 top-row*3 250 30],'tag','UsernamePopup');
		uicontrol(edit,'position',[5+100+5+250+5 top-row*3 250 30],'tag','UsernameOtherEdit');

		uicontrol(txt,'position',[5 top-row*4 600 30],'string','2: What do you want to install? (most will choose defaults)','fontweight','bold');
		uicontrol(cb,'position',[5 + 25 top-row*5 200 30],'string','vhtools','value',1,'tag','vhtoolsCB');
		uicontrol(cb,'position',[5 + 25 top-row*6 200 30],'string','vhtools_thirdparty','value',1,'tag','vhtools_thirdpartyCB');

		uicontrol(txt,'position',[5 top-row*7 500 30],'string','3: Select an installation location (you''ll need write permission)','fontweight','bold');
		uicontrol(txt,'position',[5 top-row*8 100 30],'string','Directory:');
		uicontrol(button,'position',[5+100+5 top-row*8 75 30],'string','Choose','tag','ChooseInstallDirPathBt');
		uicontrol(edit,'position',[5+100+5+75+5 top-row*8 500 30],'string','','tag','InstallPathEdit');
		
		uicontrol(txt,'position',[5 top-row*9 500 30],'string','4: Take action','fontweight','bold');
		uicontrol(button,'position',[5 top-row*10 100 30],'string','Install/Update','tag','InstallBt');
		uicontrol(button,'position',[5+100+5 top-row*10 150 30],'string','Check for local changes','tag','CheckForLocalChangesBt');
		uicontrol(button,'position',[5+100+5+150+5 top-row*10 220 30],'string','Save copy of my local version','tag','SaveLocalVersionBt');
		uicontrol(button,'position',[5+100+5+150+5+220 top-row*10 150 30],'string','Submit my changes','tag','SubmitLocalChangesBt','enable','off');
		uicontrol(button,'position',[5 top-row*11 220 30],'string','Restore Default Installer Options','tag','RestoreDefaultBt');
		uicontrol(button,'position',[5+220+5 top-row*11 60 30],'string','Help','tag','HelpBt');

		% Step 3 - Try to load any saved settings, or set defaults

		vhtools_installer('RestoreDefaultBt',fig);
        case 'HelpBt',
		helpstring = help('vhtools_installer');
		msgbox(helpstring,'Help');
	case 'RestoreDefaultBt',
		set(findobj(fig,'Tag','ServerOtherEdit'),'string','');
		set(findobj(fig,'Tag','ServerPopup'),'string',{'kfc.bio.brandeis.edu','other'},'value',1);

		set(findobj(fig,'Tag','UsernameOtherEdit'),'string','');
		set(findobj(fig,'Tag','UsernamePopup'),'string',{'vhtools1','other'},'value',1);

		set(findobj(fig,'Tag','vhtoolsCB'),'value',1);
		set(findobj(fig,'Tag','vhtools_thirdpartyCB'),'value',1);

		if isunix,
			mycurrentpath = pwd;
			cd('~'); % change to 'home' directory
			homedir = pwd;
			cd(mycurrentpath);
			default_path = [homedir filesep 'tools' ];
		elseif ispc,
			path_cellstr = pathstr2cellarray_vhi(userpath);
			default_path = [path_cellstr{1} filesep 'tools']; 
		end;
		if exist(default_path)~=7,
			try, 
				mkdir(default_path);
			catch,
				errordlg(['Tried to create the default install directory location at ' default_path ' but could not. Please create this directory manually or choose another directory for installation.'],'Error creating the directory where tools will be installed');
			end;
		end;
		set(findobj(fig,'Tag','InstallPathEdit'),'string',default_path);
		vhtools_installer('EnableDisable',fig);

	case 'ExtractVariables',
		% Extract variables from the control fields
		ud.server_other = get(findobj(fig,'Tag','ServerOtherEdit'),'string');
		ud.server_value = get(findobj(fig,'Tag','ServerPopup'),'value');
		ud.server_stringlist = get(findobj(fig,'Tag','ServerPopup'),'string');
		ud.server_string = ud.server_stringlist{ud.server_value};

		if ud.server_value==length(ud.server_stringlist),
			ud.server_string = ud.server_other;
		end;

		ud.username_other = get(findobj(fig,'Tag','UsernameOtherEdit'),'string');
		ud.username_value = get(findobj(fig,'Tag','UsernamePopup'),'value');
		ud.username_stringlist = get(findobj(fig,'Tag','UsernamePopup'),'string');
		ud.username_string = ud.username_stringlist{ud.username_value};

		if ud.username_value==length(ud.username_stringlist),
			username_string = ud.username_other;
		end;

		cbnames = {'vhtoolsCB','vhtools_thirdpartyCB'};
		for i=1:2,
			ud.checkbox{i} = get(findobj(fig,'Tag',cbnames{i}), 'value');
		end;

		ud.distnames = {'vhtools','vhtools_thirdparty'};

		ud.installpath = get(findobj(fig,'Tag','InstallPathEdit'),'string');
		if ud.installpath(end)~=filesep, ud.installpath(end+1) = filesep; end;

		%ud.other1string = get(findobj(fig,'Tag','other1Edit'),'string');
		%ud.other2string = get(findobj(fig,'Tag','other2Edit'),'string');
		%ud.vhtools_value = get(findobj(fig,'Tag','vhtoolsPopup'),'value');
		%ud.vhtools_string = get(findobj(fig,'Tag','vhtoolsPopup'),'string');
		%ud.vhtools3rdparty_string = get(findobj(fig,'Tag','vhtools3rdPartyPopup'),'string');

		set(fig,'userdata',ud);

	case 'EnableDisable',
		vhtools_installer('ExtractVariables',fig);
		ud = get(fig,'userdata'); % make sure we read the new information that was written by ExtractVariables
		if ud.server_value == length(ud.server_string), 
			set(findobj(fig,'Tag','ServerOtherEdit'),'enable','on','visible','on');
		else,
			set(findobj(fig,'Tag','ServerOtherEdit'),'enable','off','visible','off');
		end;
		if ud.username_value == length(ud.username_string),
			set(findobj(fig,'Tag','UsernameOtherEdit'),'enable','on','visible','on');
		else,
			set(findobj(fig,'Tag','UsernameOtherEdit'),'enable','off','visible','off');
		end;

	case {'ServerPopup','UsernamePopup'}
		vhtools_installer('EnableDisable',fig);

	case 'InstallBt',
		vhtools_installer('ExtractVariables',fig);
		ud = get(fig,'userdata'); % make sure we read the new information that was written by ExtractVariables

		if strcmp(ud.server_string,'kfc.bio.brandeis.edu'),
			pathname = '/Volumes/DataDrive1/SoftwareDistribution/';
		end;

		install_string = ['sftp://' ud.username_string '@' ud.server_string pathname];

		for i=1:length(ud.distnames),
			if ud.checkbox{i},
				[status,output] = system([editpathstring 'bzr stat "' ud.installpath filesep ud.distnames{i} '"']);
				str = { 'After a moment of processing, you will be prompted to enter the password for the username above. On Unix machines you will enter this password on the command line, and on Microsoft systems a separate DOS window will pop up. In both systems, the password entry will be "blind"; you will not see the text being typed, so make sure the proper window is in the front (command line or the separate DOS window).' ...
				'' ...
				'The default password is available at http://sites.google.com/site/vhlabtools/installation' ...
				'' ...
				'At the conclusion of the installation, you should see either 1) a message saying "branched N revisions", 2) a message saying "no revisions to pull", or 3) some sort of error.  The first 2 messages indicate everything worked successfully.' ...
				};
				uiwait(msgbox(str,['Installation guideline for ' ud.distnames{i}],'modal'));
				if status~=0,
					% the distribution probably doesn't exist yet
					[status,output] = system_interactive([editpathstring 'bzr branch "' install_string ud.distnames{i} '" "' ud.installpath ud.distnames{i} '"']);
					if status~=0,
						errordlg(output,['There was an error installing ' ud.distnames{i} '.']);
					else,
						%msgbox([ud.distnames{i} ' was installed successfully.'],'Installation successful');
						setup_startup_file(ud,i);
					end;
				else, % no error, probably already exists
					buttonname = 'Yes';
					if length(output)~=0,
						msgbox(output,['Changes in ' ud.distnames{i} '.']);
						buttonname = questdlg('Changes were detected in the local distribution. Are you sure you want to continue?','Are you sure?','Yes','No','No');
					end;
					if strcmp(buttonname,'Yes'),
						[status,output] = system_interactive([editpathstring 'bzr pull --overwrite "' install_string ud.distnames{i} '" --directory="' ud.installpath ud.distnames{i} '"']);
						if status~=0,
							errordlg(output,['There was an error installing ' ud.distnames{i} '.']);
						else,
							%msgbox([ud.distnames{i} ' was installed successfully.'],'Installation successful');
							setup_startup_file(ud,i);
						end;
					end;
				end;
			end;
		end;
	case 'CheckForLocalChangesBt',
		vhtools_installer('ExtractVariables',fig);
		ud = get(fig,'userdata');

		for i=1:length(ud.distnames),
			if ud.checkbox{i},
				[status,output] = system([editpathstring 'bzr stat "' ud.installpath filesep ud.distnames{i} '"']);
				if status~=0,
					errordlg(output,['Error in checking for changes in ' ud.distnames{i} '.']);
				else, % no error
					if length(output)==0,
						output = ['No changes found in ' ud.distnames{i} '.'];
					end;
					uiwait(msgbox(output,['Changes in ' ud.distnames{i} '.']));
				end;
			end;
		end;
	case 'SaveLocalVersionBt',
		vhtools_installer('ExtractVariables',fig);
		ud = get(fig,'userdata');

		time_string = datestr(now,30);

		for i=1:length(ud.distnames),
			if ud.checkbox{i},
				[success,message,messageid] = copyfile([ud.installpath filesep ud.distnames{i}],[ud.installpath filesep ud.distnames{i} '_' time_string],'f');
				if ~success,
					errordlg(message,['Error saving copy of ' ud.distnames{i} '.']);
				else,
					uiwait(msgbox(['Distribution ' ud.distnames{i} ' saved successfully as ' ud.distnames{i} '_' time_string '.']));
				end;
			end;
		end;
	case 'SubmitLocalChangesBt',
		vhtools_installer('ExtractVariables',fig);
		ud = get(fig,'userdata');
		

	case 'ChooseInstallDirPathBt',
                dirname=uigetdir;
		if ~isempty(dirname),
	                set(findobj(fig,'tag','InstallPathEdit'),'string',dirname)
		end;

	case 'CheckBzr',
        if isunix,
    		[status,output] = system([editpathstring 'which bzr']);
        elseif ispc,
            status = system([editpathstring 'bzr']);
        end;
		if status~=0,

			dlg_string = {'vhtools requires that the version tracking software bazaar be installed.',...
				'You can install this on your computer  from http://bazaar.canonical.com/' };
	
			errordlg(dlg_string,'Bazaar cannot be found');
			% error dialog here
	
			error(['Bazaar is not installed or could not be found.']);
		end;
end;  % end of switch



function [status,output] = system_interactive(command)
 % call system in a way that the user can enter a password

command,

status = 0;
output = '';

if ispc,
	[status, output] = dos([command ' & ']);
else,
	try,
		eval(['!' command]);
	catch,
		status = 1;
		output = lasterr;
	end;
end;


function path_cellstr = pathstr2cellarray_vhi(mypathstr) % embedded version of this function
pathstr = mypathstr;
sep = pathsep;

inds = [0 find(pathstr==sep)];

if inds(end)~=length(pathstr),  % make sure the last point is the point we wish to copy until
        inds(end+1) = length(pathstr)+1;
end;

path_cellstr = {};

for i=1:length(inds)-1,
        path_cellstr{i} = pathstr(inds(i)+1:inds(i+1)-1);
end;


function setup_startup_file(ud, distindex)

startup_file = which('startup');

switch ud.distnames{distindex},

	case 'vhtools',

		vhtools_startup_string = { ...
					'mydir = pwd; % line 1 save the directory where we are currently' ...
					['cd(''' ud.installpath ud.distnames{distindex} filesep 'VH_matlab_code''); % line 2 change directories to the tool path'] ...
					'vhtools_startup(pwd,1);  % line 3 installs directory paths and initializes objects' ...
					'cd(mydir);  % line 4 changes back to the previous directory' ...
					'clear mydir;  % line 5 clears the variable mydir' ...
				};

		startup_msg = { 'vhtools requires that 5 lines of code be executed to inialize the library when Matlab starts.  This code is called from the startup.m file (see help startup in Matlab).' };

		startup_file_exists = {'The installer has detected that you already have a startup.m file on your path.  Please ensure it has the following lines of code (if you have installed vhtools previously, it probably does):'};

		startup_file_doesnotexist = {'The installer has detected that you did not have a startup.m file already. We created one for you at the following location:'};

		if isempty(startup_file), % save the user choose a spot to save the startup file
			path_cellstr = pathstr2cellarray_vhi(userpath);
                        default_path = [ path_cellstr{1} ];
			startup_file = [ default_path filesep 'startup.m' ];

			fid = fopen(startup_file,'wt');
			if fid<0,
				error(['*******Could not create startup.m file at ' startup_file '.  User will need to create startup.m file.*******']);
			else, 
				for j=1:length(vhtools_startup_string),
					fprintf(fid,['%s\n'],vhtools_startup_string{j});
				end;
				fclose(fid);
			end;

			uiwait(msgbox(cat(2,startup_msg, {''}, startup_file_doesnotexist, {''}, startup_file),'Needed to create startup.m file'));
		else,
			uiwait(msgbox(cat(2,startup_msg, {''}, startup_file_exists, {''}, vhtools_startup_string),'Make sure startup.m file is suitable.'));
		end;

	case 'vhtools_thirdparty',
		% nothing to do
		return;
end;

function s = editpathstring
s = '';
if isunix&ismac,
	s = 'PATH=$PATH:/usr/local/bin;export PATH; ';
end;


