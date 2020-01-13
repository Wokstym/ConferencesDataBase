import random

cleaning = [1, 2, 5, 8]
security = [3, 4]
tech = [6, 7, 10]


def main():
    f = open("PartnersForConferencesExec.sql", "w")
    for x in range(70):
        conference_id = x + 1

        for y in range(3):
            if y == 0:
                partner_id = random.choice(cleaning)
            elif y == 1:
                partner_id = random.choice(security)
            else:
                partner_id = random.choice(tech)
            f.write(
                "EXEC AssignPartnerToConference @PartnerID = " + str(partner_id) + ", @ConferenceID = " + str(conference_id) + "\n"
                )
        if random.randint(0, 100) > 70:
            f.write(
                "EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = " + str(
                    conference_id) + "\n"
            )
    f.close()


if __name__ == "__main__":
    main()
