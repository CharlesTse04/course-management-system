package com.example.course_management.repository;

import com.example.course_management.model.Vote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface VoteRepository extends JpaRepository<Vote, Long> {
    Optional<Vote> findByUserIdAndPollId(Long userId, Long pollId);
    List<Vote> findByUserId(Long userId);
}
