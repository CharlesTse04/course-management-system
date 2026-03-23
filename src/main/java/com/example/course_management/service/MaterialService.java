package com.example.course_management.service;

import com.example.course_management.model.Material;
import com.example.course_management.repository.MaterialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MaterialService {
    
    @Autowired
    private MaterialRepository materialRepository;
    
    public List<Material> getMaterialsByLectureId(Long lectureId) {
        return materialRepository.findByLectureId(lectureId);
    }
    
    public Material getMaterialById(Long id) {
        Optional<Material> material = materialRepository.findById(id);
        return material.orElse(null);
    }
    
    public Material addMaterial(Material material) {
        return materialRepository.save(material);
    }
    
    public void deleteMaterial(Long id) {
        materialRepository.deleteById(id);
    }
    
    public void deleteMaterialsByLectureId(Long lectureId) {
        List<Material> materials = materialRepository.findByLectureId(lectureId);
        materialRepository.deleteAll(materials);
    }
}
