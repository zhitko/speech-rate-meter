#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

#include <QList>
#include <QVariant>
#include <QVariantList>

const double DefaultKSpeechRate = 36;
const double DefaultMinSpeechRate = 70;
const double DefaultMaxSpeechRate = 210;
const double DefaultKArticulationRate = 12;
const double DefaultMinArticulationRate = 70;
const double DefaultMaxArticulationRate = 210;
const double DefaultKMeanPauses = 10;

namespace IntonCore {
class Core;
class Config;
}

class Recorder;

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    virtual ~Backend();

    Q_PROPERTY(QString path READ getPath WRITE setPath)

    // Files API
    Q_INVOKABLE QVariantList getWaveFilesList();
    Q_INVOKABLE void deleteWaveFile(QString path);
    Q_INVOKABLE void playWaveFile(QString path);
    Q_INVOKABLE QString startStopRecordWaveFile();
    Q_INVOKABLE QString openFileDialog();

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
    Q_INVOKABLE QVariant getVowelsLength(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceCount(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceLength(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsCount(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getSegmentsVariance(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsMeanValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsMedianValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceMeanValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getConsonantsAndSilenceMedianValue(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getVowelsRate(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getSpeechRate(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getMeanDurationOfPauses(QString path, double from_percent, double to_percent);
    Q_INVOKABLE QVariant getArticulationRate(QString path, double from_percent, double to_percent);

    // Settings API
    Q_INVOKABLE QVariant getIntensityFrame();
    Q_INVOKABLE void setIntensityFrame(QVariant value);
    Q_INVOKABLE QVariant getIntensityShift();
    Q_INVOKABLE void setIntensityShift(QVariant value);
    Q_INVOKABLE QVariant getIntensitySmoothFrame();
    Q_INVOKABLE void setIntensitySmoothFrame(QVariant value);
    Q_INVOKABLE QVariant getIntensityMaxLengthValue();
    Q_INVOKABLE void setIntensityMaxLengthValue(QVariant value);
    Q_INVOKABLE QVariant getSegmentsByIntensityMinimumLength();
    Q_INVOKABLE void setSegmentsByIntensityMinimumLength(QVariant value);
    Q_INVOKABLE QVariant getSegmentsByIntensityThresholdAbsolute();
    Q_INVOKABLE void setSegmentsByIntensityThresholdAbsolute(QVariant value);
    Q_INVOKABLE QVariant getSegmentsByIntensityThresholdRelative();
    Q_INVOKABLE void setSegmentsByIntensityThresholdRelative(QVariant value);

    Q_INVOKABLE void setKSpeechRate(QVariant value);
    Q_INVOKABLE QVariant getKSpeechRate();
    Q_INVOKABLE void setMinSpeechRate(QVariant value);
    Q_INVOKABLE QVariant getMinSpeechRate();
    Q_INVOKABLE void setMaxSpeechRate(QVariant value);
    Q_INVOKABLE QVariant getMaxSpeechRate();
    Q_INVOKABLE void setKArticulationRate(QVariant value);
    Q_INVOKABLE QVariant getKArticulationRate();
    Q_INVOKABLE void setMinArticulationRate(QVariant value);
    Q_INVOKABLE QVariant getMinArticulationRate();
    Q_INVOKABLE void setMaxArticulationRate(QVariant value);
    Q_INVOKABLE QVariant getMaxArticulationRate();
    Q_INVOKABLE void setKMeanPauses(QVariant value);
    Q_INVOKABLE QVariant getKMeanPauses();


public:
    QString getPath();
    void setPath(const QString& path);

private:
    IntonCore::Core *core;
    IntonCore::Config *config;

    QString path;

    Recorder *recorder;

private:
    void initializeCore(bool reinit = false);
    void initializeCore(const QString& path);
    void loadFromFile(IntonCore::Config *config);
    void saveToFile(IntonCore::Config *config);
    IntonCore::Config * getConfig();

    double kSpeechRate;
    double minSpeechRate;
    double maxSpeechRate;
    double kArticulationRate;
    double minArticulationRate;
    double maxArticulationRate;
    double kMeanPauses;

signals:

};

#endif // BACKEND_H
