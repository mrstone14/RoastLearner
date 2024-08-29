# [Python Deployment for RoastLearner](#Python-Deployment-for-RoastLearner)
RoastLearner requires the installation of Python 3.12 for Windows along with several additional modules in order to execute the [PyAudioAnalysis](https://github.com/tyiannak/pyAudioAnalysis) scripts.  The latest versions of pyAudioAnalysis include the "requirements.txt" file needed to install the majority of the additional modules.  FFMPEG installation is also suggested to eliminate annoying error messages.

#### Download and install the development environment tools:

* Download Python 3.12 installer for 64bit Windows: https://www.python.org/downloads/
* Run Python 3.12 installer. Install for all users, accept the default install location (this will change once we tell Python to add to Path), then select the installation option "Add python.exe to Path" at the bottom of the Customize Python step on the next screen (you might need to scroll to find it).  This will change the default install location to C:\Program Files\Python312.
* Download and Install GitHub Desktop from https://desktop.github.com/
* Download FFMPEG from https://www.ffmpeg.org/download.html#build-windows.  You can download the Windows version using your preferred method (e.g. gyan.dev or BtnN build).
* Extract the contents of the FFMPEG download to a folder of your choice that will not change (e.g. C:\Program Files\ffmpeg) and then add the "bin" subfolder to path:
    * To manually add a directory to Path, click the Windows start key/button, search for "Edit the System Environment Variables" and open the corresponding control panel settings application.  
    * Under the "Advanced" tab, click the "Environment Variables" button at the bottom of the window.  This will open a new window where you will see "User variables for (user)" and "System Variables" subwindows.  
    * Under "User variables for (user)", scroll down to the Variable called "Path", select this line and then click "Edit...".  
    * In the next window that pops up, click "New" and add the path to your FFMPEG bin folder (e.g. C:\Program Files\ffmpeg\bin). 
    * Click "OK" on all the open windows and FFMPEG will be good to go.

#### Install pyAudioAnalysis and development libraries:
* The latest versons of pyAudioAnalysis has all of the required Python libraries that we will need included in a "requirements.txt" file.  Therefore, we will download and install pyAudioAnalysis next.
* Open an admin command prompt or PowerShell session.
* You'll likely start in C:\WINDOWS\system32, so let's head over to the default Python scripts folder before we begin:

```
cd "C:\Program Files\Python312\Scripts"
```

* Paste the following to make sure pip is all up-to-date.

```
pip install --upgrade pip
```

* In the command prompt/PowerShell window, clone the pyAudioAnalysis repo with the following command:

```
git clone https://github.com/tyiannak/pyAudioAnalysis.git C:\Program Files\Python312\scripts\pyAudioAnalysis
```

* Change to the new folder:

```
cd "C:\Program Files\Python312\scripts\pyAudioAnalysis"
```

* Install all required libraries:

```
pip install -r ./requirements.txt
```
If you get an error on this step or the one below, make sure you ran your command prompt/PowerShell session as admin!

* Install pyAudioAnalysis:

```
pip install -e .
```

* Finally, test the installation by running an analysis against the included test data:

```
cd "C:\Program Files\Python312\Scripts\pyAudioAnalysis\pyAudioAnalysis"
python audioAnalysis.py fileChromagram -i data/doremi.wav
```

If everything worked correctly the script should open a window that looks something like this:

![Successful example output](images/fileChromagram.png?raw=true "Successful example output")

Great! Now we can move on to [Installing RoastLearner](Install_RoastLearner.md#RoastLearner-Installation)!
