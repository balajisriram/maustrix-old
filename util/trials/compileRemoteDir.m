function compileRemoteDir(boxes,mice,recompile)

if ~exist('boxes','var') || isempty(boxes)
    boxes = {'Box1','Box2','Box3','Box4','Box4'};
elseif ~iscell(boxes)
    error('either dont give boxes or give it as a sequence of cellstrs');
end

if ~exist('mice','var') || isempty(mice)
    mice = 'all';
elseif ~iscell(mice)
    error('either dont give mice or give it as a sequence of cellstrs');
end

if ~exist('recompile','var') || isempty(recompile)
    recompile = false;
elseif ~isogical(recompile)
    error('recompile should be a logical');
end
BaseDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\';

for i = 1:length(boxes)
    currBoxDir = fullfile(BaseDir,boxes{i});
    miceInBox = dir(fullfile(currBoxDir,'Permanent'));
    miceInBox = miceInBox([miceInBox.isdir]);
    miceInBox = miceInBox(~ismember({miceInBox.name},{'.','..','.DS_Store','.AppleDouble'}));
    miceInBox = {miceInBox.name};
    if isstr(mice) && strcmp(mice,'all')
        miceToCompile = miceInBox;
    else
        miceToCompile = intersect(mice,miceInBox);
    end
    for j = 1:length(mice)
        error('not yet ready');
    end
end
end