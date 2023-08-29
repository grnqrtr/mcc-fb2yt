import subprocess
from flask import Flask, request, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    if request.method == 'POST':
        # Retrieve form data
        facebook_link = request.form.get('facebook_link')
        youtube_title = request.form.get('youtube_title')
        youtube_description = request.form.get('youtube_description')

        # Construct the command to open a terminal and execute the shell script
        command = 'gnome-terminal -- ./fb2yt.sh "{}" "{}" "{}"'.format(
            facebook_link, youtube_title, youtube_description
        )
        try:
            subprocess.run(command, shell=True)
            return 'Video upload process started!'
        except subprocess.CalledProcessError:
            return 'An error occurred while starting the video upload process.'

if __name__ == '__main__':
    app.run()
