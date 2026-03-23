package com.example.course_management.dto;

public class WordCloudDTO {
    private String text;
    private int size;
    
    public WordCloudDTO() {}
    
    public WordCloudDTO(String text, int size) {
        this.text = text;
        this.size = size;
    }
    
    public String getText() { return text; }
    public void setText(String text) { this.text = text; }
    
    public int getSize() { return size; }
    public void setSize(int size) { this.size = size; }
}
