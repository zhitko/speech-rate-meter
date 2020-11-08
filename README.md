# Speech Rate Meter

The Speech Rate Meter (hereinafter SRM) software module is designed to measure a complex of characteristics of the tempo (rate) of oral speech.

Distinctive features:
The assessment of the complex of characteristics of the speech rate is carried out by measuring in real time:
* Actual rate of speech (number of words per minute, taking into account the duration of interphrase pauses) - Speech Rate (wpm)
* Speech articulation rate (words per minute minus the duration of interphrase pauses) - Articulation Rate (wpm)
* Average duration of inter-phrase pauses - Phrase Pauses (sec).
* The total duration of the speech segment - Speech Duration (sec)

Recommended areas of application:
* Self-study and self-control of the rate of speech in the preparation and conduct of speeches and presentations;
* Individual training of oral and speech skills in a number of professions such as: call center operators, radio, TV announcers, etc.;
* Monitoring of the rate of speech of call-center operators, radio and TV broadcasters;
* Improving the skills of reading texts in native and foreign languages;
* Self-control tool for eliminating speech defects, diagnostics and treatment of speech pathologies;

SRM is implemented as a standalone application for Windows (7, 8, 10), Linux, Android (in progress now). 

## Installation

Currently on our website (see https://intontrainer.by ) the SRM prototype is uploaded, available for free download.

## Build from source

Use QT Creator or CMake to build Speech Rate Meter.
You need to build Inton Core library first.

```bash
git clone git@github.com:zhitko/inton-core.git
git clone git@github.com:zhitko/speech-rate-meter.git

cd inton-core
cmake --build . --target all
cmake --build . --target install

cd ../speech-rate-meter
cmake --build . --target all
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Authors

Development:
* [Zhitko Vladimir](https://www.linkedin.com/in/zhitko-vladimir-92662255/)

Scientific:
* [Boris Lobanov](https://www.linkedin.com/in/boris-lobanov-50628384/)

## License
[MIT](https://choosealicense.com/licenses/mit/)
