//
//  NetworkingStub.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

let upcomingMovieSuccessStub = "{\"results\":[{\"vote_count\":230,\"id\":458156,\"video\":false,\"vote_average\":7.4,\"title\":\"John Wick: Chapter 3 – Parabellum\",\"popularity\":463.957,\"poster_path\":\"\\/ziEuG1essDuWuC5lpWUaw1uXY2O.jpg\",\"original_language\":\"en\",\"original_title\":\"John Wick: Chapter 3 – Parabellum\",\"genre_ids\":[80,28,53],\"backdrop_path\":\"\\/5Wo36oWzdblY5Fgvbws0L43trRq.jpg\",\"adult\":false,\"overview\":\"In this third installment of the adrenaline-fueled action franchise, super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail. After killing a member of the shadowy international assassin’s guild, the High Table, John Wick is excommunicado, but the world’s most ruthless hit men and women await his every turn.\",\"release_date\":\"2019-05-15\"}],\"page\":1,\"total_results\":323,\"dates\":{\"maximum\":\"2019-06-15\",\"minimum\":\"2019-05-19\"},\"total_pages\":17}".data(using: .utf8)!

let upcomingMovieDecodingFailedStub = "{\"results\":[{vote_count\":230,\"id\":458156,\"video\":false,\"vote_average\":7.4,\"title\":\"John Wick: Chapter 3 – Parabellum\",\"popularity\":463.957,\"poster_path\":\"\\/ziEuG1essDuWuC5lpWUaw1uXY2O.jpg\",\"original_language\":\"en\",\"original_title\":\"John Wick: Chapter 3 – Parabellum\",\"genre_ids\":[80,28,53],\"backdrop_path\":\"\\/5Wo36oWzdblY5Fgvbws0L43trRq.jpg\",\"adult\":false,\"overview\":\"In this third installment of the adrenaline-fueled action franchise, super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail. After killing a member of the shadowy international assassin’s guild, the High Table, John Wick is excommunicado, but the world’s most ruthless hit men and women await his every turn.\",\"release_date\":\"2019-05-15\"}],\"page\":1,\"total_results\":323,\"dates\":{\"maximum\":\"2019-06-15\",\"minimum\":\"2019-05-19\"},\"total_pages\":17}".data(using: .utf8)!
