//
//  Database.swift
//  AnimalProjects
//
//  Created by Grava Andy on 04/03/2026.
//

import Foundation

//var animaux: [Animal] = [
//    Animal(species: .bovine, idNumber: "AB2357", name: "Daisy", isMale: false, production: .milk, isPregnant: false),
//]

var animaux: [Animal] = [
    Animal(
        photo: "vache1",
        species: .bovine,
        idNumber: "AB2357",
        name: "Daisy",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2020, month: 3, day: 15)
        ),
        isMale: false,
        production: .milk,
        isPregnant: false
    ),
    Animal(
        photo: "chevre1",
        species: .caprine,
        idNumber: "CP8472",
        name: "Bella",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2021, month: 5, day: 10)
        ),
        isMale: false,
        production: .milk,
        isPregnant: true
    ),
    Animal(
        photo: "mouton1",
        species: .ovine,
        idNumber: "OV3921",
        name: "Nuage",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2022, month: 2, day: 5)
        ),
        isMale: true,
        production: .wool,
        isPregnant: false
    ),
    Animal(
        photo: "cheval1",
        species: .equine,
        idNumber: "EQ5568",
        name: "Spirit",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2018, month: 7, day: 22)
        ),
        isMale: true,
        production: nil,
        isPregnant: false
    ),
    Animal(
        photo: "cochon1",
        species: .porcine,
        idNumber: "PR7810",
        name: "Rosie",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2023, month: 1, day: 12)
        ),
        isMale: false,
        production: .meat,
        isPregnant: false
    ),
    Animal(
        photo: "vache2",
        species: .bovine,
        idNumber: "AB9981",
        name: "Marguerite",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2019, month: 11, day: 3)
        ),
        isMale: false,
        production: .milk,
        isPregnant: true
    ),
    Animal(
        photo: "chevre2",
        species: .caprine,
        idNumber: "CP9023",
        name: "Choupette",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2020, month: 8, day: 14)
        ),
        isMale: false,
        production: .milk,
        isPregnant: false
    ),
    Animal(
        photo: "mouton2",
        species: .ovine,
        idNumber: "OV7744",
        name: "Flocon",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2021, month: 4, day: 2)
        ),
        isMale: false,
        production: .wool,
        isPregnant: true
    ),
    Animal(
        photo: "taureau1",
        species: .bovine,
        idNumber: "AB4412",
        name: "Titan",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2017, month: 9, day: 30)
        ),
        isMale: true,
        production: .meat,
        isPregnant: false
    ),
    Animal(
        photo: "jument1",
        species: .equine,
        idNumber: "EQ6631",
        name: "Étoile",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2019, month: 6, day: 18)
        ),
        isMale: false,
        production: nil,
        isPregnant: false
    ),
    Animal(
        photo: "cochon2",
        species: .porcine,
        idNumber: "PR5520",
        name: "Babe",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2022, month: 10, day: 9)
        ),
        isMale: true,
        production: .meat,
        isPregnant: false
    ),
    Animal(
        photo: "brebis1",
        species: .ovine,
        idNumber: "OV1189",
        name: "Luna",
        dateOfBirth: Calendar.current.date(
            from: DateComponents(year: 2020, month: 12, day: 25)
        ),
        isMale: false,
        production: .milk,
        isPregnant: false
    ),
]

var communityCategories: [CommunityCategory] = [
    CommunityCategory(
        title: "Discussions et Entraide",
        description: "Posez vos questions et partagez vos expériences",
        threadNumber: 18,
        activeName: "discussions ouvertes"
    ),
    CommunityCategory(
        title: "Santé et Soins",
        description: "Conseils vétérinaires et urgences",
        threadNumber: 5,
        activeName: "discussions en cours"
    ),
    CommunityCategory(
        title: "Reproduction et mise en relation",
        description: "Trouvez un animal et échanger sur la génétique",
        threadNumber: 12,
        activeName: "demandes actives"
    ),
    CommunityCategory(
        title: "Réglementations et Aides",
        description:
            "Restez Informés des évolutions légales, déclarations et aides",
        threadNumber: 4,
        activeName: "mises à jour ce mois-ci"
    ),
]
