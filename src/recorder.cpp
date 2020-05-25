#include "recorder.h"

#include <QAudioRecorder>
#include <QAudioEncoderSettings>
#include <QAudioDeviceInfo>
#include <QUrl>
#include <QDateTime>
#include <QGuiApplication>
#include <QDir>
#include "applicationconfig.h"

Recorder::Recorder(QObject *parent) : QObject(parent), is_recording(false), audio_recorder(nullptr)
{
    this->reinitializeAudioRecorder();
}

Recorder::~Recorder()
{
    freeAudioRecorder();
}

Recorder *Recorder::getInstance()
{
    static Recorder * instance = new Recorder();
    return instance;
}

QString Recorder::startRecording()
{
    this->is_recording = true;

    QString appPath = QGuiApplication::applicationDirPath();
    QString dataPath = ApplicationConfig::GetFullDataPath();
    QDir dataDir(dataPath);
    if (!dataDir.exists()) dataDir.mkpath(".");
    QString path = dataDir.absoluteFilePath(
        QDateTime::currentDateTime().toString(ApplicationConfig::RecordingFileNameTemplate) + ".wav"
        );

    qDebug() << path;

    this->destination_file = path;

    this->audio_recorder->setOutputLocation(
        QUrl::fromLocalFile(this->destination_file)
    );
    this->audio_recorder->record();

    qDebug() << "supportedContainers :" << this->audio_recorder->supportedContainers();
    qDebug() << "supportedFrameRates :" << this->audio_recorder->supportedFrameRates();
    qDebug() << "supportedAudioCodecs :" << this->audio_recorder->supportedAudioCodecs();
    qDebug() << "supportedAudioSampleRates :" << this->audio_recorder->supportedAudioSampleRates();

    return path;
}

QString Recorder::stopRecording()
{
    this->audio_recorder->stop();
    this->is_recording = false;

    reinitializeAudioRecorder();

    QString path = this->destination_file;
    this->destination_file = "";

    return path;
}

bool Recorder::isRecording()
{
    return this->is_recording;
}

void Recorder::reinitializeAudioRecorder()
{
    freeAudioRecorder();

    this->audio_recorder = new QAudioRecorder;

    QAudioEncoderSettings audioSettings;
    audioSettings.setEncodingMode(QMultimedia::ConstantBitRateEncoding);
    audioSettings.setSampleRate(ApplicationConfig::RecordingFrequency);
    audioSettings.setChannelCount(ApplicationConfig::RecordingChannelsCount);
    audioSettings.setBitRate(
        ApplicationConfig::RecordingChannelsCount
        * ApplicationConfig::RecordingFrequency
        * ApplicationConfig::RecordingBitsPerSample);

    this->audio_recorder->setEncodingSettings(audioSettings);

    QAudioDeviceInfo info = QAudioDeviceInfo::defaultInputDevice();

    this->audio_recorder->setAudioInput(info.deviceName());
    this->audio_recorder->setContainerFormat(ApplicationConfig::RecordingContainerFormat);
}

void Recorder::freeAudioRecorder()
{
    if (this->audio_recorder != nullptr)
    {
        if (this->is_recording)
        {
            this->audio_recorder->stop();
        }
        delete this->audio_recorder;
    }
}
