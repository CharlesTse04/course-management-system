package com.example.course_management.service;

import com.example.course_management.model.Lecture;
import com.example.course_management.repository.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class LectureService {
    
    @Autowired
    private LectureRepository lectureRepository;
    
    public List<Lecture> getAllLectures() {
        return lectureRepository.findAll();
    }
    
    public Lecture getLectureById(Long id) {
        return lectureRepository.findById(id).orElse(null);
    }
    
    public Lecture saveLecture(Lecture lecture) {
        return lectureRepository.save(lecture);
    }
    
    public void deleteLecture(Long id) {
        lectureRepository.deleteById(id);
    }

    public Lecture createLecture(Lecture lecture) {
        return lectureRepository.save(lecture);
    }

}
    
