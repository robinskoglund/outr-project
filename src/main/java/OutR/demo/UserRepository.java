package OutR.demo;

import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// using standard CRUD commands

public interface UserRepository extends CrudRepository<User, Integer> {
}
