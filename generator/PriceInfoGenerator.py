import random
import re

EarlierGeneratedNrOfConferenceDays = 354
NrOfEmployeeIDs = 68

FilePath = 'ConferencesAndConferenceDaysExec.sql'


def main():
    # Parse file to get conference days into array
    data = []
    with open(FilePath, 'r') as file:
        line = file.readline()
        while line:
            if re.compile('\tEXEC AddConferenceDay (.*)').match(line):
                conf = re.compile('\tEXEC AddConferenceDay (.*)').match(line).group(1).split(",")
                day_number = conf[0].split("= ")[1]
                participant_limit = conf[1].split("= ")[1]
                date = conf[2].split("= '")[1].split("'")[0]
                conference_id = conf[3].split("= ")[1]
                conference = [day_number, participant_limit, date, conference_id]
                data.append(conference)
            line = file.readline()
    print(data)

    # Price info generator
    f = open("PriceInfoExec.sql", "w")
    conference_day_id = "0"
    for conference_day in data:
        conference_day_id = str(int(conference_day_id)+1)
        student_discount = "%.3f" % (random.random() / 2)
        date = conference_day[2].split("-")

        year = int(date[0])
        month = int(date[1]) - random.randint(6, 10)
        day = random.randint(1, 28)

        if month <= 0:
            month += 12
            year -= 1

        date1 = str(year) + "-" + str(month).zfill(2) + "-" + str(day).zfill(2)
        price1 = 80 * int(conference_day[1]) + random.randint(0, 10) * 50

        year = int(date[0])
        month = int(date[1]) - 2
        day = date[2]

        if month <= 0:
            month += 12
            year -= 1
        date2 = str(year) + "-" + str(month).zfill(2) + "-" + day
        price2 = price1 * 1.25

        year = int(date[0])
        month = int(date[1]) - 1
        if month <= 0:
            month += 12
            year -= 1
        date3 = str(year) + "-" + str(month).zfill(2) + "-" + day
        price3 = price1 * 1.75
        f.write(
            "EXEC AddPriceInfo @ConferenceDayID = " + conference_day_id + ", @InitialDate = '" + date1 +
            "', @Price = " + str(price1) + ", @StudentDiscount = " + str(student_discount) + "\n" +
            "EXEC AddPriceInfo @ConferenceDayID = " + conference_day_id + ", @InitialDate = '" + date2 +
            "', @Price = " + str(price2) + ", @StudentDiscount = " + str(student_discount) + "\n" +
            "EXEC AddPriceInfo @ConferenceDayID = " + conference_day_id + ", @InitialDate = '" + date3 +
            "', @Price = " + str(price3) + ", @StudentDiscount = " + str(student_discount) + "\n"
        )
    f.close()


if __name__ == "__main__":
    main()
