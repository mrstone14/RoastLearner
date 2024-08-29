@echo off
:: train classifiers with supervised data in class folders
setlocal disableDelayedExpansion

:: path to RoastLearner installation
set RoastLearnerDir=%~dp0
:: path to Python executable
set py3dir=C:\Program Files\Python312
:: Path to recordings
set recordingDir=%LOCALAPPDATA%\RoastLearner

:: Check for default installation of Python 3
set py3exe=%py3dir%\python.exe
if not exist "%py3exe%" (
  echo FATAL: Python 3 interpreter not found at "%py3exe%".
  echo Please install Python 3 for Windows under the default
  echo folder.  Refer to the installation guide for details.
  goto end
)

:: Check for installation of PyAudioAnalysis under py3dir\scripts\pyAudioAnalysis\pyAudioAnalysis
set pyAudioAnalysis=%py3dir%\Scripts\pyAudioAnalysis\pyAudioAnalysis
if not exist "%pyAudioAnalysis%\audioAnalysis.py" (
  echo FATAL: AudioAnalysis not found at "%pyAudioAnalysis%\audioAnalysis.py"
  echo Please install pyAudioAnalysis and required libraries.
  echo Refer to the installation guide for details.
  goto end
)

:: Check for classified recordings folders
if not exist "%recordingDir%\classified_recordings\*" (
  echo FATAL: Could not find any class folders under "%recordingDir%\classified_recordings"
  goto end
)

pushd "%recordingDir%\classifiers"

:: Check to see if we have an existing trained model and back it up if so
if not exist RoastLearner* goto train_classifiers

:: check to see if our backup folder exists, make it if not
if not exist "trained_classifier_backup" md "trained_classifier_backup"
if not exist "trained_classifier_backup" echo FATAL: failed to create folder "trained_classifier_backup" && goto end

:: create a new incremental backup folder 
for /L %%v in (1,1,9999) do if not exist "trained_classifier_backup\backup_%%v" set backup_folder=trained_classifier_backup\backup_%%v && goto create_backup_folder
:create_backup_folder
md "%backup_folder%"
if not exist "%backup_folder%" echo FATAL: failed to create folder "%backup_folder%" && goto end

move RoastLearnerSVM*.* "%backup_folder%"
move RoastLearnerKNN*.* "%backup_folder%"

:train_classifiers
set class_list=
for /D %%z in ("..\classified_recordings"\*) do call set class_list=%%class_list%% "..\classified_recordings\%%z"

"%py3exe%" "%pyAudioAnalysis%\audioAnalysis.py" trainClassifier -i %class_list% --method svm -o RoastLearnerSVM
"%py3exe%" "%pyAudioAnalysis%\audioAnalysis.py" trainClassifier -i %class_list% --method knn -o RoastLearnerKNN

if not exist "RoastLearnerSVM" (
  echo FATAL: Failed to create SVM classifier.  Exiting.
  echo.
  pause
  goto end
)
if not exist "RoastLearnerKNN" (
  echo FATAL: Failed to create KNN classifier.  Exiting.
  echo.
  pause
  goto end
)

echo SUCCESS: Classifiers trained against classified recordings
pause
goto end

:end
popd