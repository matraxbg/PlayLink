import os, requests, zipfile, re
from io import BytesIO

from win32com.client import Dispatch

from selenium import webdriver
from selenium.common.exceptions import WebDriverException
from selenium.common.exceptions import SessionNotCreatedException

def download_chromedriver(version):
    url = "https://chromedriver.storage.googleapis.com/"+version+"/chromedriver_win32.zip"
    filename = url.split('/')[-1]
    req = requests.get(url)
    print('Downloading Completed')

    zipfile.zipfile = zipfile.ZipFile(BytesIO(req.content))
    zipfile.zipfile.extractall()

    if os.path.exists(filename):
        os.remove(filename)

def get_version_via_com(filename):
    parser = Dispatch("Scripting.FileSystemObject")
    try:
        version = parser.GetFileVersion(filename)
    except Exception:
        return None
    return version

def check_chromedriver_version(chrome_version):
    try:
        driver = webdriver.Chrome("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\chromedriver.exe")
        version = driver.capabilities['chrome']['chromedriverVersion'].split(' ')[0]
        print("chromedriver.exe version is ok")
    except SessionNotCreatedException as err1:
        print("Different chromedriver.exe version")
        download_chromedriver(chrome_version)
    except WebDriverException as err2:
        print("No chromedriver.exe")
        download_chromedriver(chrome_version)

if __name__ == "__main__":
    paths = [r"C:\Program Files\Google\Chrome\Application\chrome.exe",
             r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"]
    version = list(filter(None, [get_version_via_com(p) for p in paths]))[0]
    print(version)
    check_chromedriver_version(version)

