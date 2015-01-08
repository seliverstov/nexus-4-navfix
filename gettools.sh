#!/bin/bash
if tools/checktools.sh; then
    echo "Tools are already installed."
    exit 0
fi

URL="https://github.com/gkraynov/nexus-4-navfix/releases/download/v0.0/tools.tar.gz"

function pause(){
   read -p "$*"
}

echo
echo "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR"
echo "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,"
echo "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE"
echo "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER"
echo "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,"
echo "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE"
echo "SOFTWARE."
echo
echo "3rd-party files:"
echo "1) apktool.jar"
echo "2) zipalign"
echo "3) update-binary (in update_blank.zip)"
echo
echo "I don't know anything about these file's contents, stay at YOUR OWN RISK!"
echo
echo "Licenses:"
echo
echo "== APK Tool =="
echo "Apache License 2.0"
echo "Origin: https://code.google.com/p/android-apktool"
echo
echo "== zipalign =="
echo "Android Software Development Kit License"
echo "Terms: https://developer.android.com/sdk/terms.html"
echo "Origin: Android SDK"
echo
echo "== update-binary =="
echo "Unknown License (widely distributed in fact)"
echo "Origin: Some update.zip for Nexus 4"
echo
pause "Press [Enter] to continue (if you agree with the text above)..."

echo "Downloading..."
rm -f tools/tools.tar.gz
curl -o tools/tools.tar.gz -L $URL &>/dev/null

if [ ! -f "tools/tools.tar.gz" ]; then
    echo "Download failed"
    exit 1
fi

echo "Extracting..."
cd tools
tar -xzf tools.tar.gz &>/dev/null
rm tools.tar.gz
cd ..

if ! tools/checktools.sh; then
    echo "Failed to install tools"
    exit 1
else
    echo "Tools installed."
fi
