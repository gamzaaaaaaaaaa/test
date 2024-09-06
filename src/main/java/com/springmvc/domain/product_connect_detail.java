package com.springmvc.domain;

public class product_connect_detail {
    private String korean;
    private String english;
    private String warningLevel; // 경고 수준 추가

    public product_connect_detail() {
        super();
    }

    public String getKorean() {
        return korean;
    }

    public void setKorean(String korean) {
        this.korean = korean;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getWarningLevel() {
        return warningLevel;
    }

    public void setWarningLevel(String warningLevel) {
        this.warningLevel = warningLevel;
    }
    
    @Override
    public String toString() {
        return "product_connect_detail{" +
               "korean='" + korean + '\'' +
               ", english='" + english + '\'' +
               ", warningLevel='" + warningLevel + '\'' +
               '}';
    }
}
