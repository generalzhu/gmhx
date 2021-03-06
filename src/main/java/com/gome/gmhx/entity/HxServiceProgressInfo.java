package com.gome.gmhx.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HxServiceProgressInfo {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column hx_service_progress_info.service_id
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    private String serviceId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column hx_service_progress_info.progress_description
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    private String progressDescription;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column hx_service_progress_info.recorder
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    private String recorder;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column hx_service_progress_info.record_time
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date recordTime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column hx_service_progress_info.service_id
     *
     * @return the value of hx_service_progress_info.service_id
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public String getServiceId() {
        return serviceId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column hx_service_progress_info.service_id
     *
     * @param serviceId the value for hx_service_progress_info.service_id
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column hx_service_progress_info.progress_description
     *
     * @return the value of hx_service_progress_info.progress_description
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public String getProgressDescription() {
        return progressDescription;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column hx_service_progress_info.progress_description
     *
     * @param progressDescription the value for hx_service_progress_info.progress_description
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public void setProgressDescription(String progressDescription) {
        this.progressDescription = progressDescription;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column hx_service_progress_info.recorder
     *
     * @return the value of hx_service_progress_info.recorder
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public String getRecorder() {
        return recorder;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column hx_service_progress_info.recorder
     *
     * @param recorder the value for hx_service_progress_info.recorder
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column hx_service_progress_info.record_time
     *
     * @return the value of hx_service_progress_info.record_time
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public Date getRecordTime() {
        return recordTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column hx_service_progress_info.record_time
     *
     * @param recordTime the value for hx_service_progress_info.record_time
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table hx_service_progress_info
     *
     * @mbggenerated Fri Aug 29 14:58:16 CST 2014
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", serviceId=").append(serviceId);
        sb.append(", progressDescription=").append(progressDescription);
        sb.append(", recorder=").append(recorder);
        sb.append(", recordTime=").append(recordTime);
        sb.append("]");
        return sb.toString();
    }
}