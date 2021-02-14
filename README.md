A docker image for running Kurt Zoglmann's Morse-Code-Ninja render application. You can run it locally in an interactive session using the command below. Note that you will need to provide AWS credentials as environment variables. See https://github.com/zoglmannk/Morse-Code-Ninja for more information on AWS setup.

1. `docker run -it --env AWS_KEY_ID=SECRET --env AWS_SECRET_ACCESS_KEY=SECRET -p 3000:3000 sklegg/morsecodeninja`

2. `node /opt/Morse-Code-Ninja-Site-master/app/app.js`

3. Open http://localhost:3000/index.html in a browser.