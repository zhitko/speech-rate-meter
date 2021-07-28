#include "backend.h"

#include <cmath>

#include <QDebug>
#include <QDir>
#include <QGuiApplication>
#include <QSound>
#include <QFileDialog>
#include <QStandardPaths>

#include <inton-core/include/intoncore.h>
#include <inton-core/include/utils.h>

#include "applicationconfig.h"
#include "settings.h"
#include "recorder.h"
#include "pcm_recorder.h"
#include "qml/qmlfileinfo.h"
#include "qml/qmlpoint.h"


const int WAVE_LENGTH = 1000;

Backend::Backend(QObject *parent)
    : QObject(parent),
    core(nullptr),
    sound(nullptr)
{
    this->path = "";

    this->recorder = PcmRecorder::getInstance();
}

Backend::~Backend()
{
    qDebug() << "~Backend";

    if(this->core != nullptr) delete this->core;
}

Settings *Backend::getSettings()
{
    return Settings::getInstance();
}

bool Backend::isOpenAvailable()
{
#ifdef ANDROID
    return false;
#else
    return true;
#endif
}

QVariantList Backend::getWaveFilesList()
{
    QDir dataDir(ApplicationConfig::GetFullDataPath());
    QStringList allFiles = dataDir.entryList(ApplicationConfig::WaveFileFilter, QDir::NoDotAndDotDot | QDir::Files);
    qDebug() << "Found files: " << allFiles;

    QVariantList fileList;

    foreach(auto file, allFiles)
    {
        QmlFileInfo info(dataDir.absoluteFilePath(file));
        qDebug() << "File: " << info.getName() << " : " << info.getPath();

        fileList.append(QVariant::fromValue(info));
    }

    return fileList;
}

void Backend::deleteWaveFile(QString path)
{
    qDebug() << "deleteWaveFile " << path;
    QFile file (path.toLocal8Bit());
    file.remove();
}

void Backend::playWaveFile(QString path, bool stop)
{
    if (!stop)
    {
        if (!stop && this->sound) this->sound->deleteLater();
        this->sound = new QSound(path);
        this->sound->play();
    }
    else if (stop && this->sound)
    {
        this->sound->stop();
    }
}

QString Backend::startStopRecordWaveFile()
{
    QString path = "";
    if (!this->recorder->isRecording())
    {
        qDebug() << "Backend::startStopRecordWaveFile: start recording";
        path = this->recorder->startRecording();
        this->path = path;
    } else {
        qDebug() << "Backend::startStopRecordWaveFile: stop recording";
        WaveFile * file = this->recorder->stopRecording();
        qDebug() << "Backend::startStopRecordWaveFile: reset wave file " << file;
        this->initializeCore();
        this->core->reloadTemplate(file);
    }

    qDebug() << "Backend::startStopRecordWaveFile: complete - " << path;
    return path;
}

QString Backend::openFileDialog()
{
#ifdef ANDROID
    auto fileUrl = QFileDialog::getOpenFileUrl(nullptr,
                                tr("Open File"),
                                ApplicationConfig::GetFullTestsPath(),
                                tr("Wave (*.wav)"));
    qDebug() << "openFileDialog: " << fileUrl;
    auto fileName = fileUrl.toString();
#else
    auto fileName = QFileDialog::getOpenFileName(nullptr,
        tr("Open File"),
        ApplicationConfig::GetFullTestsPath(),
        tr("Wave (*.wav)"));
#endif
    qDebug() << "openFileDialog: " << fileName;    

    return fileName;
}

QString Backend::loadResult()
{
    QFile file(ApplicationConfig::GetFullResultsPath());
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return "";

    QTextStream in(&file);
    QString results = "";

    while(!in.atEnd()) {
        results += in.readLine().replace("|","\n");
        results += "\n\n";
    }

    file.close();

    return results;
}

void Backend::saveResult(QString startTime, QString endTime, QString speechRate, QString articulationRate, QString phrasePause, QString speechDuration)
{
    qDebug() << "startTime: " << startTime;
    qDebug() << "endTime: " << endTime;
    qDebug() << "speechRate: " << speechRate;
    qDebug() << "articulationRate: " << articulationRate;
    qDebug() << "phrasePause: " << phrasePause;
    qDebug() << "speechDuration: " << speechDuration;
    QFile results(ApplicationConfig::GetFullResultsPath());
    if (!results.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Append))
        return;
    QTextStream out(&results);
    out << "Date&Time(Star&End) - " << startTime << " - " << endTime << "|" <<
           "Speech Rate - " << speechRate << "|"
           "Articulation Rate - " << articulationRate << "|"
           "Phrase Pause - " << phrasePause << "|"
           "Speech Duration - " << speechDuration << "\n";
    results.close();
}

QVariantList Backend::getWaveData(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getWaveNormalized();
    auto resized_data = IntonCore::resizeVectorByMinMax(data, WAVE_LENGTH);
    qDebug() << "getWaveData: file size: " << data.size();

    QVariantList waveData;

    for (ulong i=0; i<resized_data.size(); i++) {
        waveData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return waveData;
}

QVariantList Backend::getIntensity(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getIntensityNormalized();
    auto resized_data = IntonCore::resizeVector(data, WAVE_LENGTH);

    qDebug() << "getIntensity size " << data.size();

    QVariantList intensityData;

    for (ulong i=0; i<resized_data.size(); i++) {
        intensityData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return intensityData;
}

QVariantList Backend::getIntensitySmoothed(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getIntensityNormalizedSmoothed();
    auto resized_data = IntonCore::resizeVector(data, WAVE_LENGTH);

    qDebug() << "Intensity smoothed size " << data.size();

    QVariantList intensityData;

    for (ulong i=0; i<resized_data.size(); i++) {
        intensityData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return intensityData;
}

QVariantList Backend::getWaveSegmantData(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto data = storage->getWaveNormalized();
    int from = static_cast<int>(std::ceil(data.size() * std::min(from_percent, to_percent)));
    int to = static_cast<int>(std::ceil(data.size() * std::max(from_percent, to_percent)));
    std::vector<double>::const_iterator first = data.begin() + from;
    std::vector<double>::const_iterator last = data.begin() + to;
    std::vector<double>  cutted_data(first, last);
    auto resized_data = IntonCore::resizeVectorByMinMax(cutted_data, WAVE_LENGTH);

    qDebug() << "getWaveSegmantData: file size; " << data.size();

    QVariantList waveData;

    for (ulong i=0; i<resized_data.size(); i++) {
        waveData.append(QVariant::fromValue(QmlPoint(i, resized_data[i])));
    }

    return waveData;
}

QVariantList Backend::getSegmentsP(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto data = storage->getManualSegmentsP();

    qDebug() << "getSegmentsP count: " << data.size();

    QVariantList segments;

    for (auto &it : data)
    {
        it.first = IntonCore::normalizeValue(it.first, wave.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, wave.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsN(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto data = storage->getManualSegmentsN();
    qDebug() << "getSegmentsN Segments N count: " << data.size();

    QVariantList segments;

    for (auto &it: data)
    {
        it.first = IntonCore::normalizeValue(it.first, wave.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, wave.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsT(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto data = storage->getManualSegmentsT();
    qDebug() << "getSegmentsT Segments T count: " << data.size();

    QVariantList segments;

    for (auto &it: data)
    {
        it.first = IntonCore::normalizeValue(it.first, wave.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, wave.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsByIntensity(QString path)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto intensity = storage->getIntensity();

    auto data = storage->getAutoSegmentsByIntensitySmoothed();

    qDebug() << "getSegmentsByIntensity count: " << data.size();

    QVariantList segments;

    for (auto &it: data)
    {
        it.first = IntonCore::normalizeValue(it.first, intensity.size(), WAVE_LENGTH);
        it.second = IntonCore::normalizeValue(it.second, intensity.size(), WAVE_LENGTH);
        segments.append(QVariant::fromValue(QmlPoint(it.first, it.first + it.second)));
    }

    return segments;
}

QVariantList Backend::getSegmentsByIntensityMask(QString path, double from_percent, double to_percent)
{
    qDebug() << "getSegmentsByIntensityMask: " << from_percent << " " << to_percent;
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto intensity = storage->getIntensity();

    auto data = storage->getAutoSegmentsByIntensitySmoothedMask();

    qDebug() << "getSegmentsByIntensityMask count: " << data.size();
    int from = static_cast<int>(std::round(data.size() * std::min(from_percent, to_percent)));
    qDebug() << "getSegmentsByIntensityMask from: " << from;
    int to = static_cast<int>(std::round(data.size() * std::max(from_percent, to_percent)));
    qDebug() << "getSegmentsByIntensityMask to: " << to;

    int count = 20;

    int segment_size = 1.0 * (to - from) / count;
    qDebug() << "getSegmentsByIntensityMask segment_size: " << segment_size;

    QVariantList result;

    int value = 0;
    for (int i=0; i<count; i++)
    {
        value = 0;
        for (int j=0; j<segment_size; j++) {
            if (from+i*segment_size+j < data.size())
            {
                value += data[from+i*segment_size+j];
            }
        }
        result.append(QVariant::fromValue(value));
    }

    return result;

}

QVariant Backend::getWaveLength(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto wave = storage->getWave();

    auto select = abs(to_percent - from_percent);

    return QVariant::fromValue(1.0 * wave.size() / ApplicationConfig::RecordingFrequency * select);
}

QVariant Backend::getVowelsLength(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto length = storage->getVowelsLength();

    qDebug() << "getVowelsLength: " << length;

    return QVariant::fromValue(storage->convertIntensityPointsToSec(length));
}

QVariant Backend::getVowelsMax(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(from_percent * segments_mask.size());
    uint32_t to = static_cast<uint32_t>(to_percent * segments_mask.size());
    qDebug() << "getVowelsMax from: " << from;
    qDebug() << "getVowelsMax to: " << to;

    uint32_t max = 0;
    uint32_t current = 0;
    for (uint32_t i=from; i<to && i<segments_mask.size(); i++)
    {
        if (segments_mask[i] == 1) current++;
        else current = 0;

        if (current > max) max = current;
    }

    qDebug() << "getVowelsMax: " << max;

    return QVariant::fromValue(storage->convertIntensityPointsToSec(max));
}

QVariant Backend::getConsonantsAndSilenceCount(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getConsonantsAndSilenceCount();

    qDebug() << "getConsonantsAndSilenceCount: " << count;

    return QVariant::fromValue(count);
}

QVariant Backend::getConsonantsAndSilenceLength(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto length = storage->getConsonantsAndSilenceLength();

    qDebug() << "getConsonantsAndSilenceLength: " << length;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(length));
}

QVariant Backend::getConsonantsAndSilenceMax(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "getConsonantsAndSilenceMax from: " << from;
    qDebug() << "getConsonantsAndSilenceMax to: " << to;

    uint32_t max = 0;
    uint32_t current = 0;
    for (uint32_t i=from; i<to && i<segments_mask.size(); i++)
    {
        if (segments_mask[i] == 0)
        {
            current++;
            if (current > max) max = current;
        }
        else current = 0;

    }

    qDebug() << "getConsonantsAndSilenceMax: " << max;

    return QVariant::fromValue(storage->convertIntensityPointsToSec(max));
}

QVariant Backend::getVowelsCount(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getVowelsCount();

    qDebug() << "getVowelsCount: " << count;

    return QVariant::fromValue(count);

}

QVariant Backend::getSegmentsVariance(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "getSegmentsVariance from: " << from;
    qDebug() << "getSegmentsVariance to: " << to;

    uint32_t mx2 = 0;
    uint32_t mx = 0;
    for (uint32_t i=from; i<to; i++)
    {
        if (segments_mask[i]) mx += i;
        if (segments_mask[i]) mx2 += i * i;
    }

    qDebug() << "getSegmentsVariance: mx2" << mx2;
    qDebug() << "getSegmentsVariance: mx" << mx;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(mx2 - mx*mx));

}

QVariant Backend::getVowelsMeanValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    auto result = storage->getVowelsLengthMean();

    qDebug() << "getVowelsMeanValue: mx" << result;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(result));
}

QVariant Backend::getVowelsSquareMeanValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();

    Settings * settings = Settings::getInstance();

    auto result = storage->getVowelsLengthGeneralizedMean(settings->getMeanValueDegry().toDouble());

    qDebug() << "getVowelsSquareMeanValue: mx" << result;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(result));
}

QVariant Backend::getVowelsMedianValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothed();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "getVowelsMedianValue from: " << from;
    qDebug() << "getVowelsMedianValue to: " << to;

    std::vector<uint32_t> selected_segments;

    for (auto &it: segments)
    {
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            selected_segments.push_back(it.second);
        }
    }

    sort(selected_segments.begin(), selected_segments.end());

    uint32_t median = IntonCore::getMedianValue(selected_segments);

    qDebug() << "getVowelsMedianValue median: " << median;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(median));
}

QVariant Backend::getConsonantsAndSilenceMeanValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto result = storage->getConsonantsAndSilenceLengthMean();

    qDebug() << "getConsonantsAndSilenceMeanValue: " << result;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(result));
}

QVariant Backend::getConsonantsAndSilenceMeanSquareValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    Settings * settings = Settings::getInstance();

    auto storage = this->core->getTemplate();
    auto result = storage->getConsonantsAndSilenceLengthGeneralizedMean(settings->getMeanValueDegry().toDouble());

    qDebug() << "getConsonantsAndSilenceMeanSquareValue: " << result;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(result));
}

QVariant Backend::getConsonantsAndSilenceMedianValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto segments = storage->getAutoSegmentsByIntensitySmoothedInverted();

    auto segments_mask = storage->getAutoSegmentsByIntensitySmoothedMask();

    uint32_t from = static_cast<uint32_t>(std::ceil(from_percent * segments_mask.size()));
    uint32_t to = static_cast<uint32_t>(std::ceil(to_percent * segments_mask.size()));
    qDebug() << "getConsonantsAndSilenceMedianValue from: " << from;
    qDebug() << "getConsonantsAndSilenceMedianValue to: " << to;

    std::vector<int> selected_segments;

    for (auto &it: segments)
    {
        if ( from < (it.first+it.second) && (it.first) < to )
        {
            selected_segments.push_back(it.second);
        }
    }

    sort(selected_segments.begin(), selected_segments.end());

    uint32_t median = IntonCore::getMedianValue(selected_segments);

    qDebug() << "getConsonantsAndSilenceMedianValue median: " << median;

    return QVariant::fromValue( storage->convertIntensityPointsToSec(median));
}

QVariant Backend::getVowelsRate(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto waveLength = this->getWaveLength(path, from_percent, to_percent).toDouble();
    auto segmentsCount = this->getVowelsCount(path, from_percent, to_percent).toDouble();

    qDebug() << "getVowelsRate median: " << segmentsCount;
    qDebug() << "getVowelsRate median: " << waveLength;

    return QVariant::fromValue(segmentsCount / waveLength);
}

QVariant Backend::getSpeechRate(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);
    Settings * settings = Settings::getInstance();

    qDebug() << "getSpeechRate K1:" << settings->getKSpeechRate();

    auto nv = this->getVowelsCount(path, from_percent, to_percent).toDouble();
    auto ts = this->getWaveLength(path, from_percent, to_percent).toDouble();
    double speechRate = settings->getKSpeechRate().toDouble() * nv * 60 / ts;

    qDebug() << "getSpeechRate:" << speechRate;

    return QVariant::fromValue(speechRate);
}

QVariant Backend::getMeanDurationOfPauses(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);    
    Settings * settings = Settings::getInstance();

    qDebug() << "getMeanDurationOfPauses K3:" << settings->getKMeanPauses();
    auto tcm = this->getConsonantsAndSilenceMeanSquareValue(path, from_percent, to_percent).toDouble();
    auto tcd = this->getConsonantsAndSilenceMedianValue(path, from_percent, to_percent).toDouble();
    if (tcm < tcd) return QVariant::fromValue(0.0);
    double meanDurationOfPauses = settings->getKMeanPauses().toDouble() * (tcm - tcd) / tcd;

    qDebug() << "getMeanDurationOfPauses:" << meanDurationOfPauses;

    return QVariant::fromValue(meanDurationOfPauses);
}

QVariant Backend::getMeanFillerSounds(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);
    Settings * settings = Settings::getInstance();

    qDebug() << "getMeanFillerSounds K4:" << settings->getKFillerSounds();

    auto tva = this->getVowelsSquareMeanValue(path, from_percent, to_percent).toDouble();
    auto tvm = this->getVowelsMedianValue(path, from_percent, to_percent).toDouble();
    if (tva < tvm) return QVariant::fromValue(0.0);
    double meanFillerSounds = settings->getKFillerSounds().toDouble() * (tva - tvm) / tvm;

    qDebug() << "getMeanFillerSounds:" << meanFillerSounds;

    return QVariant::fromValue(meanFillerSounds);
}

QVariant Backend::getArticulationRate(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);
    Settings * settings = Settings::getInstance();

    qDebug() << "getArticulationRate K2:" << settings->getKArticulationRate();

    auto rs = this->getSpeechRate(path, from_percent, to_percent).toDouble();
    auto ts = this->getWaveLength(path, from_percent, to_percent).toDouble();
    auto tv = this->getVowelsLength(path, from_percent, to_percent).toDouble();
    auto tcpm = this->getConsonantsAndSilenceMedianValue(path, from_percent, to_percent).toDouble();
    auto nc = this->getConsonantsAndSilenceCount(path, from_percent, to_percent).toInt();
    double articulationRate = rs * ts / (tv + settings->getKArticulationRate().toDouble() * tcpm * nc);

    qDebug() << "getArticulationRate:" << articulationRate;

    auto speechRate = this->getSpeechRate(path, from_percent, to_percent);
    if (speechRate.toDouble() > articulationRate) return speechRate;

    return QVariant::fromValue(articulationRate);
}

QVariant Backend::getVowelsVarianceValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getVowelsLengthVariance();

    qDebug() << "getVowelsVarianceValue:" << count;

    return QVariant::fromValue(count);
}

QVariant Backend::getConsonantsAndSilenceVarianceValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getConsonantsAndSilenceLengthVariance();

    qDebug() << "getConsonantsAndSilenceVarianceValue:" << count;

    return QVariant::fromValue(count);
}

QVariant Backend::getVowelsSkewnessValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getVowelsLengthSkewness();

    qDebug() << "getVowelsSkewnessValue:" << count;

    return QVariant::fromValue(count);
}

QVariant Backend::getConsonantsAndSilenceSkewnessValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getConsonantsAndSilenceLengthSkewness();

    qDebug() << "getConsonantsAndSilenceSkewnessValue:" << count;

    return QVariant::fromValue(count);
}

QVariant Backend::getVowelsKurtosisValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getVowelsLengthKurtosis();

    qDebug() << "getVowelsKurtosisValue:" << count;

    return QVariant::fromValue(count);
}

QVariant Backend::getConsonantsAndSilenceKurtosisValue(QString path, double from_percent, double to_percent)
{
    this->initializeCore(path);

    auto storage = this->core->getTemplate();
    auto count = storage->getConsonantsAndSilenceLengthKurtosis();

    qDebug() << "getConsonantsAndSilenceKurtosisValue:" << count;

    return QVariant::fromValue(count);
}

QString Backend::getPath()
{
    return this->path;
}

void Backend::setPath(const QString &path)
{
    qDebug() << "set path: " << path;
    this->path = path;
}

void Backend::initializeCore(bool reinit)
{
    qDebug() << "Backend::initializeCore";
    if (this->core != nullptr && !reinit) return;

    if (this->core != nullptr)
    {
        qDebug() << "Backend::initializeCore: Delete core";
        delete this->core;
        this->core = nullptr;
    }

    QString recordsPath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation);
    QString logPath = QDir(recordsPath).absoluteFilePath("core.log");
    qDebug() << "Backend::initializeCore: logPath: " << logPath;

    Settings * settings = Settings::getInstance();

    qDebug() << "Backend::initializeCore: Initialize core: " << this->path;
    this->core = new IntonCore::Core(
        this->path.toStdString(),
        settings->getConfig()
    );
    qDebug() << "Backend::initializeCore: Initialize core complete";
}

void Backend::initializeCore(const QString& path)
{
    qDebug() << "initializeCore: path" << path;
    if (this->path == path) return;
    qDebug() << "initializeCore: old path" << this->path;

    if (!path.isEmpty())
    {
        qDebug() << "initializeCore: initialize core" << path;
        this->initializeCore();
        qDebug() << "initializeCore: load wav file" << path;
        WaveFile * file = IntonCore::Helpers::openWaveFile(path.toStdString());
        qDebug() << "initializeCore: reload template" << path;
        this->core->reloadTemplate(file);
    }

    this->setPath(path);
}
