package com.example.course_management.repository;

import com.example.course_management.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByLectureId(Long lectureId);
    List<Comment> findByPollId(Long pollId);
    List<Comment> findByUserId(Long userId);
}
