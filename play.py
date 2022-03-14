import sys, getopt, requests, time, subprocess, re, os, pyautogui
import checkversion

from vars import *
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.service import Service

# Kill chrome.exe and chromedriver.exe processes
subprocess.call("TASKKILL /f  /IM  CHROME.EXE")
subprocess.call("TASKKILL /f  /IM  CHROMEDRIVER.EXE")

paths = [r"C:\Program Files\Google\Chrome\Application\chrome.exe",
             r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"]
version = list(filter(None, [checkversion.get_version_via_com(p) for p in paths]))[0]
print(version)
checkversion.check_chromedriver_version(version)

# Find link using regex
def Find(string):
    regex = r"(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'\".,<>?«»“”‘’]))"
    url = re.findall(regex,string)      
    return [x[0] for x in url]

# Link parameter
for i, arg in enumerate(sys.argv):
    input = arg

link = Find(input)
if not link:
    file = input.replace("/","\\")
    try:
        os.startfile("\\\\"+smb_server+file)
        link = ""
    except:
        sys.exit(2)
else:
    link = link[0]

    # Setup chromedriver
    service = Service("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\chromedriver.exe")
    service.start()
    opts = webdriver.ChromeOptions()
    opts.add_argument("user-data-dir=C:\\Users\\"+windows_user+"\\AppData\\Local\\Google\\Chrome\\User Data")
    opts.add_argument("--disable-notifications")
    opts.add_argument("start-maximized")
    prefs = {'exit_type': 'Normal'} 
    opts.add_experimental_option("detach", True)
    opts.add_experimental_option("prefs", {'profile': prefs})
    opts.add_experimental_option("excludeSwitches",["enable-automation"])
    driver = webdriver.Remote(service.service_url,options=opts)

    # Run chromedriver  
    driver.get(link)
    driver.implicitly_wait(5)
    if "youtube.com" in link or "youtu.be" in link:
        element = WebDriverWait(driver,2).until(EC.element_to_be_clickable((By.XPATH,"//button [@class='ytp-fullscreen-button ytp-button']")))
        element.send_keys(Keys.ENTER)
    elif "twitch.tv" in link:
        element = WebDriverWait(driver,1).until(EC.element_to_be_clickable((By.XPATH,"//button [@class='ScCoreButton-sc-1qn4ixc-0 NUuwz ScButtonIcon-sc-o7ndmn-0 fCvKRl'][@aria-label='Fullscreen (f)']")))
        element.send_keys(Keys.ENTER)
    elif "netflix.com" in link:
        try:
            element = WebDriverWait(driver,1).until(EC.element_to_be_clickable((By.XPATH,"//span [@class='profile-name'][contains(text(), '"+netflix_user+"')]/..")))
            element.send_keys(Keys.ENTER)
        except BaseException as err:
            print('Cannot find username.')
        element = WebDriverWait(driver,1).until(EC.element_to_be_clickable((By.CSS_SELECTOR,"a.primary-button.playLink.isToolkit")))
        element.send_keys(Keys.ENTER)
        time.sleep(2)
        pyautogui.press('TAB')
        time.sleep(2)
        pyautogui.press('f')
    elif "primevideo.com" in link:
        element = WebDriverWait(driver,1).until(EC.element_to_be_clickable((By.XPATH,"//a [@class='_1ovr-S _15Ikr8 _3kM4Lo hym-nE _2vHmSA _2X_Irl TKV4YL']")))
        element.send_keys(Keys.ENTER)
        time.sleep(2)
        pyautogui.press('TAB')
        time.sleep(2)
        pyautogui.press('f')
    else:
        sys.exit(2)

# Write link in data.txt
file = data_file_location
f = open(file,'w+')
f.write(link)
f.close