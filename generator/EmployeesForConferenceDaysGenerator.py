import random

EarlierGeneratedNrOfConferenceDays = 354
NrOfEmployeeIDs = 68


def main():
    f = open("EmployeesForConferenceDaysExec.sql", "w")
    used_employees = []
    for x in range(EarlierGeneratedNrOfConferenceDays):
        conference_day_id = x + 1

        used_employees.clear()
        for y in range(random.randint(4, 10)):

            while True:
                employee_id = random.randint(1, NrOfEmployeeIDs)
                if employee_id not in used_employees:
                    used_employees.append(employee_id)
                    break
            f.write(
                "EXEC AssignEmployeeToConferenceDay @EmployeeID = " + str(employee_id) + ", @ConferenceDayID = " +
                str(conference_day_id) + "\n"
                )

    f.close()


if __name__ == "__main__":
    main()
