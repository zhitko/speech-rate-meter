#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

#include <QList>
#include <QVariant>
#include <QVariantList>

namespace IntonCore {
class Core;
}

class Recorder;
class PcmRecorder;
class Settings;

class QSound;

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    virtual ~Backend();

    Q_PROPERTY(QString path READ getPath WRITE setPath)

    Q_INVOKABLE Settings* getSettings();

    // Files API
    Q_INVOKABLE QVariantList getWaveFilesList();
    Q_INVOKABLE void deleteWaveFile(QString path);
    Q_INVOKABLE void playWaveFile(QString path, bool stop);
    Q_INVOKABLE QString startStopRecordWaveFile();
    Q_INVOKABLE QString openFileDialog();

    Q_INVOKABLE QString loadResult();
    Q_INVOKABLE void saveResult(
        QString startTime,
        QString endTime,
        QString speechRate,
        QString articulationRate,
        QString phrasePause,
        QString speechDuration
    );

    // WAVE file API
    Q_INVOKABLE QVariantList getWaveData(QString path);
    Q_INVOKABLE QVariantList getWaveSegmantData(QString path, double from_percent, double to_percent);

    // Intensity API
    Q_INVOKABLE QVariantList getIntensity(QString path);
    Q_INVOKABLE QVariantList getIntensitySmoothed(QString path);

    // Segments API
    Q_INVOKABLE QVariantList getSegmentsP(QString path);
    Q_INVOKABLE QVariantList getSegmentsN(QString path);
    Q_INVOKABLE QVariantList getSegmentsT(QString path);
    Q_INVOKABLE QVariantList getSegmentsByIntensity(QString path);

    // Segments Mask API
    Q_INVOKABLE QVariantList getSegmentsByIntensityMask(QString path, double from_percent, double to_percent);

    // Metrics API
    Q_INVOKABLE QVariant getWaveLength(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsCount(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsLength(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsMax(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceCount(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceLength(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceMax(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getSegmentsVariance(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsMeanValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsSquareMeanValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsMedianValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceMeanValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceMeanSquareValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceMedianValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsRate(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getSpeechRate(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getMeanDurationOfPauses(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getArticulationRate(QString path, double from_percent, double to_percent);

    Q_INVOKABLE QVariant getVowelsVarianceValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceVarianceValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsSkewnessValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceSkewnessValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsKurtosisValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceKurtosisValue(QString path, double from_percent, double to_percent);

public:
    QString getPath();
    void setPath(const QString& path);

private:
    IntonCore::Core *core;

    QString path;

    QSound *sound;

    PcmRecorder *recorder;

private:
    void initializeCore(bool reinit = false);
    void initializeCore(const QString& path);

signals:

};

#endif // BACKEND_H
