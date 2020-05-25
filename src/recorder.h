#ifndef RECORDER_H
#define RECORDER_H

#include <QObject>

class QAudioRecorder;

class Recorder : public QObject
{
    Q_OBJECT
private:
    explicit Recorder(QObject *parent = nullptr);
    virtual ~Recorder();

public:
    static Recorder *getInstance();

    QString startRecording();
    QString stopRecording();

    bool isRecording();

protected:
    bool is_recording;
    QAudioRecorder *audio_recorder;
    QString destination_file;

    void reinitializeAudioRecorder();
    void freeAudioRecorder();

signals:

};

#endif // RECORDER_H
