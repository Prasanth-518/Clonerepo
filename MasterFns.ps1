param(
    [Parameter(Mandatory=$true)]
    [string]$operation
)

#pushing data into remote repo
function push_into_repo(){
    git add .
    echo "Enter commit msg"
    $msg=read-host
    git commit -m $msg
    git push origin master

}

#merging data from other branches to master branch
function merge_repos(){
    #get list of all branches
    $current_dir=get-location
    $list_branch=ls "$current_dir\.git\refs\remotes\origin"
    
    #filter the list
    $merge_list="master"
    foreach($branch in $list_branch){
        if($branch.name -notlike "HEAD" -and $branch.name -notlike "master"){
            $merge_list="{0} origin/{1}"-f $merge_list,$branch.name
        }
    }
    
    #perform merge
    git merge $merge_list
    git push origin master
}

switch($operation){
    "push"{
        push_into_repo
    }
    "merge"{
        merge_repos
    }
}