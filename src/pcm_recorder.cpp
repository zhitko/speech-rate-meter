#include "pcm_recorder.h"

#include <QDateTime>
#include <QDebug>

#ifdef ANDROID
#include <QtAndroidExtras/QtAndroid>
#endif

#include "applicationconfig.h"

PcmRecorder::PcmRecorder(QObject *parent) : QObject(parent),
    is_recording(false),
    audio(nullptr),
    buffer(nullptr)
{
    this->reinitializeAudioRecorder();
}

PcmRecorder::~PcmRecorder()
{
    this->freeAudioRecorder();
}

PcmRecorder *PcmRecorder::getInstance()
{
    static PcmRecorder * instance = new PcmRecorder();
    return instance;
}

QString PcmRecorder::startRecording()
{
    this->is_recording = true;

    QString dataPath = ApplicationConfig::GetFullDataPath();
    QDir dataDir(dataPath);
    if (!dataDir.exists()) dataDir.mkpath(".");

    QString path = dataDir.absoluteFilePath(
        QDateTime::currentDateTime().toString(ApplicationConfig::RecordingFileNameTemplate) + ApplicationConfig::RecordingFileFormat
    );

    qDebug() << path;

    this->destination_file = path;

    this->audio->start(this->buffer);

    return path;
}

WaveFile * PcmRecorder::stopRecording()
{
    this->is_recording = false;

    QString path = this->destination_file;
    this->destination_file = "";

    this->audio->stop();

    WaveFile * file = IntonCore::Helpers::makeSimpleWaveFileFromRawData(
        path.toStdString(),
        this->buffer->data().constData(),
        this->buffer->size(),
        ApplicationConfig::RecordingChannelsCount,
        ApplicationConfig::RecordingFrequency,
        ApplicationConfig::RecordingBitsPerSample,
        false
    );

    this->reinitializeAudioRecorder();

    return file;
}

bool PcmRecorder::isRecording()
{
    return this->is_recording;
}

void PcmRecorder::reinitializeAudioRecorder()
{
    this->freeAudioRecorder();

#ifdef ANDROID
    auto  result = QtAndroid::checkPermission(QString("android.permission.RECORD_AUDIO"));
    if(result == QtAndroid::PermissionResult::Denied){
        QtAndroid::PermissionResultMap resultHash = QtAndroid::requestPermissionsSync(QStringList({"android.permission.RECORD_AUDIO"}));
        if(resultHash["android.permission.RECORD_AUDIO"] == QtAndroid::PermissionResult::Denied)
        {
            qWarning() << "Denied android.permission.RECORD_AUDIO";
            return;
        }
    }
#endif

    QAudioFormat format;
    // Set up the desired format, for example:
    format.setSampleRate(ApplicationConfig::RecordingFrequency);
    format.setChannelCount(ApplicationConfig::RecordingChannelsCount);
    format.setSampleSize(ApplicationConfig::RecordingBitsPerSample);
    format.setCodec(ApplicationConfig::RecordingAudioFormat);
    format.setByteOrder(QAudioFormat::LittleEndian);
    format.setSampleType(QAudioFormat::SignedInt);

    QAudioDeviceInfo info = QAudioDeviceInfo::defaultInputDevice();
    if (!info.isFormatSupported(format)) {
        qWarning() << "Default format not supported, trying to use the nearest.";
        format = info.nearestFormat(format);
        qDebug() << "nearestFormat.sampleRate " << format.sampleRate();
        qDebug() << "nearestFormat.channelCount " << format.channelCount();
        qDebug() << "nearestFormat.sampleSize " << format.sampleSize();
        qDebug() << "nearestFormat.codec " << format.codec();
        qDebug() << "nearestFormat.byteOrder " << format.byteOrder();
        qDebug() << "nearestFormat.sampleType " << format.sampleType();
    }

    this->audio = new QAudioInput(format, this);
    this->buffer = new QBuffer(this);
    this->buffer->open(QBuffer::ReadWrite);
}

void PcmRecorder::freeAudioRecorder()
{
    if (this->audio != nullptr)
    {
        if (this->is_recording)
        {
            this->audio->stop();
        }
        delete this->audio;
    }

    if (this->buffer != nullptr)
    {
        delete this->buffer;
    }
}
