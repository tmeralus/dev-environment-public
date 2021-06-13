# pull multiple github repos using gh-cli
USER_NAME='tmeralus'
GIT_DIR="/home/${USER_NAME}/github"
GIT_1019_DIR="${GIT_DIR}/1019studios"
GIT_ANSIBLE_DIR="${GIT_DIR}/ansible/roles"
GIT_CODE_DIR="${GIT_DIR}/code"
GIT_DND_DIR="${GIT_DIR}/dnd-podcast"
GIT_DOCKER_DIR="${GIT_DIR}/docker" 
GIT_GAME_DIR="${GIT_DIR}/game"
GIT_MERCURY_DIR="${GIT_DIR}/mercury"
GIT_SCHOOL_DIR="${GIT_DIR}/school"
GIT_WEB_DIR="${GIT_DIR}/web"
GIT_TEST_DIR="${GIT_DIR}/test"

echo "CREATING GITHUB DIRS"
if [ -d "$GIT_DIR" ];
then
  mkdir $GIT_1019_DIR
  mkdir $GIT_ANSIBLE_DIR
  mkdir $GIT_CODE_DIR
  mkdir $GIT_DND_DIR
  mkdir $GIT_DOCKER_DIR
  mkdir $GIT_DOCKER_DATA_DIR
  mkdir $GIT_GAME_DIR
  mkdir $GIT_MERCURY_DIR
  mkdir $GIT_SCHOOL_DIR
  mkdir $GIT_WEB_DIR
  mkdir $GIT_WORK_DIR
  mkdir $GIT_TEST_DIR
fi

echo "INSTALLING 1019 REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone 1019studios/${LINE} $GIT_1019_DIR/${LINE}
done < scripts/git-repos/1019.list

echo "INSTALLING ANSIBLE REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_ANSIBLE_DIR/${LINE}
done < scripts/git-repos/ansible.list

echo "INSTALLING CODE REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_CODE_DIR/${LINE}
done < scripts/git-repos/code.list

echo "INSTALLING DND REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone somediceguys/${LINE} $GIT_DND_DIR/${LINE}
done < scripts/git-repos/dnd.list

echo "INSTALLING DOCKER REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_DOCKER_DIR/${LINE}
done < scripts/git-repos/docker.list

echo "INSTALLING GAME REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_GAME_DIR/${LINE}
done < scripts/git-repos/game.list

echo "INSTALLING MERCURY REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_MERCURY_DIR/${LINE}
done < scripts/git-repos/mercury.list

echo "INSTALLING SCHOOL REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_SCHOOL_DIR/${LINE}
done < scripts/git-repos/school.list

echo "INSTALLING TEST REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_TEST_DIR/${LINE}
done < scripts/git-repos/test.list

echo "INSTALLING WEB REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_WEB_DIR/${LINE}
done < scripts/git-repos/web.list

echo "INSTALLING WORK REPOS"
while IFS='' read -r LINE || [ -n "${LINE}" ]; do
    gh repo clone tmeralus/${LINE} $GIT_WORK_DIR/${LINE}
done < scripts/git-repos/work.list
