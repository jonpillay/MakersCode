
class CohortRepository
  def find_with_students(id)
    sql = 'SELECT cohort.id
                  cohort.name
                  cohort.start_date
                  student.id AS student_id
                  student.name
          FROM cohorts
          JOIN students ON students.cohort_id = cohort.id
          WHERE cohort.id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    
    cohort = Cohort.new
    
    cohort.id = result.first['id']
    cohort.name = result.first['name']
    cohort.start_date = result.first['start_date']

    result.each do |student|
      obj = Student.new
      obj.id = student['id']
      obj.name = student['name']
      obj.cohort_id = student['cohort_id']
      cohort.students < obj
    end
  end
end