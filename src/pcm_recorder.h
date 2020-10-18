#ifndef PCM_RECORDER_H
#define PCM_RECORDER_H

#include <QObject>
#include <QAudioInput>
#include <QBuffer>

class PcmRecorder : public QObject
{
    Q_OBJECT
public:
    explicit PcmRecorder(QObject *parent = nullptr);
    virtual ~PcmRecorder();

public:
    static PcmRecorder *getInstance();

    QString startRecording();
    QString stopRecording();

    bool isRecording();

protected:
    bool is_recording;
    QString destination_file;

    QAudioInput* audio;
    QBuffer* buffer;

    void reinitializeAudioRecorder();
    void freeAudioRecorder();
};

#endif // PCM_RECORDER_H
