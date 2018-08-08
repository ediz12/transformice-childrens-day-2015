--[[

	THE IDEA
	--------

	1) THE GENERAL IDEA

	The general event will take inside a school and the mice's purpose will be decorate the classrooms and the school overall
	There will be a teachers department room and in there, there will be a box that the mice will take one piece of something,
	And there will be a teacher sitting on his chair, telling the mouse where to put that thing,
	And the mouse will go to the desired place and put it there, and will gain a "point"
	When everything is put in the places, there will be a kind of celebration afterwards
	This is how the school roughly would look like in draft:
	http://prntscr.com/6mkyxp
	Integrated to TFMs gameplay of course

	1.1) ARTS
	Art in progess, woo!

	TO DO:,

	Coding :
	Event :
	1) Check if the player is on box and take the item !!DONE!!
	2) Make sure no double takes !!DONE!!
	3) If he dies, put it back !!DONE!!
	4) If he leaves room, put it back !!DONE!!
	5) Make a NPC who will say where the mouse will go !!DONE!!
	6) Check if mouse placed item there !! DONE !!
	6.1) Finish the UI at top !! DONE !!
	7) Give mouse a point for winning !! DONE !!
	8) Remove the textarea and all the necessary stuff after placing an item !! DONE !!
	9) When everything is set up, celebrate! Woo! !! DONE !!
	9.1) Move NPC to stage and make him say the TR poem !! DONE !!
	9.2) Fireworks -- CANCELLED --

	Misc : DONE
	1) Replace items when art is done !! DONE !!
	2) (MAYBE) Make an arrow pointer to show where the mouse should go !! DONE !!
	3) How to play instructions in the very beginning -- CANCELLED --
	4) Duplicates of last item if box is empty  -- i think makinit did this? !! DONE !!
	5) (MAYBE) Enigma/puzzle?? -- CANCELLED --

	Art :
	1) School interior, classes etc !! DONE !!
	2) School exterior -- CANCELLED ? --
	3) Outside  !! DONE !!
	4) Items !! DONE !!
	5) NPC teacher !! DONE !!
	6) Fixthe art positions please, Liam!

	Translations:
	[23:15] [•] [FR] Francaise : weyaprincess DONE
	[23:15] [•] [RU] Russe : Lllllllina DONE
	[23:15] [•] [BR] Bresilienne : tuliomumic DONE
	[23:15] [•] [ES] Espagnole : Kissyta DONE
	[23:15] [•] [CN] Taiwanaise : Piratearthur DONE
	[23:15] [•] [TR] Turque : ediz / deneyfaresi DONE
	[23:15] [•] [VK] Scandinave : Ordboka DONE
	[23:15] [•] [PL] Polonaise : Coska DONE
	[23:15] [•] [HU] Hongroise : vogul DONE
	[23:15] [•] [NL] Neerlandaise : anythin DONE
	[23:15] [•] [RO] Roumaine : tarmacadam DONE
	[23:15] [•] [ID] Indonesienne : xiaojiemei DONE
	[23:15] [•] [DE] Allemande : nachtfell / apfelzimt DONE
	[23:15] [•] [AR] Arabe : Tweetis
	[23:15] [•] [PH] Philippins : rainee DONE
	[23:15] [•] [LT] Lituaniene : Lolismiles DONE
	[23:15] [•] [JP] Japonaise :  ykr DONE
	[23:15] [•] [CH] Chinoise : NOT A  REAL COMMUNITY
	[23:15] [•] [FI] Finlandaise : Minnma DONE
	[23:15] [•] [CZ] Tcheque : Sabusha DONE
	[23:15] [•] [SK] Slovaque : Sabusha DONE
	[23:15] [•] [HR] Croate :
	[23:15] [•] [BG] Bulgare :
	[23:15] [•] [LV] Letton : bembijs DONE
	[23:15] [•] [HE] Israelien :
	[23:15] [•] [IT] Italien : Pyrenia DONE
	[23:15] [•] [EE] Estonienne :
	[23:15] [•] [AZ] Azerbaidjan : NOT A REAL COMMUNITY

	WIP: AR (Apparently impossible)
	Important ones: BG
	Less Important ones: HE (Apparently impossible)/ EE

]]

-- GENERAL FUNCTIONS --


playerData=true
tfm.exec.disableAfkDeath(true)

--[[saveFile=false
stats={}

function saveStats(community)
	if not stats[community] then stats[community]={celebrations=0,topplayers={}} end
	stats[community].celebrations=stats[community].celebrations+1
	table.sort(stats[community].topplayers,function(i,v) return i.score>v.score end)
	for key,value in pairs(stats[community].topplayers) do
		if key>10 then
			table.remove(stats[community].topplayers[key])
		end
	end
	system.saveFile(tabletostring(stats),99)
end

function printInfo(name, value, tabs)
	tabs = tabs or "";
	local t = type(value);
	tfm.exec.chatMessage(tabs .. t .. " " .. tostring(name) .. " = " .. tostring(value));
	if t == "table" then
		for n, v in pairs(value) do
			if v == value then
				tfm.exec.chatMessage(tabs .. "\tself " .. n);
			else
				printInfo(n, v, tabs .. "\t");
			end
		end
	end
end

function string.split(str,s)
	local res = {}
	for part in string.gmatch(str, "[^" .. s .. "]+") do
		table.insert(res, part)
	end
	return res
end]]--

-- INNER CIRCLE --

function inner_circle(x1,y1,r1,x2,y2,r2) -- (x - x1) ^ 2 + (y - y1) ^ 2 < r * r
	local x=x2-x1
	local y=y2-y1
	local r=r2+r1
	return x*x+y*y< r * r
end

-- TABLE SHUFFLE --

function table.shuffle(t)
	local t = t
	local n = #t
	local j
	local random = math.random
	for i = 1, n do
		j = random(i)
		t[j],t[i] = t[i],t[j]
	end
	return t
end


-- TRANSLATION FUNCTION --

translations = {
	EN = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Quick, we need to rush! We need to finish decorating the school as soon as possible! Go into the box and pick up an item by pressing <vp>SPACE<n>!",
		itemTaken = "Take that <vp>%s<n> to <vp>%s<n> please! Then come back to pick up another item!",
		itemTaken2 = "<j>• [Event ^_^]<vp> You have received <j>%s<vp>! Take it to <j>%s<vp>, and then come back to teacher's room to pick up another item!",
		alreadyHave = "<j>• [Event ^_^]<vp> You already have <j>%s<vp>! Take it to <j>%s<vp>, and then come back to teacher's room to pick up another item!",
		wellDone = "<j>• [Event ^_^]<vp> Well done! Now go back to the teachers room again to pick up another item!",
		endEvent = "<j>• [Event ^_^]<vp> Woo hoo! Your teacher is proud of you! Happy Childrens Day, mice!",
		cheeseFlag = "cheese flag",
		octopus = "octopus",
		flagString = "flag strings",
		balloons = "balloons",
		kite = "kite",
		handPaint = "hand paints",
		decor = "paper people chain",
		decor2 = "sunflower",
		decor3 = "paper people circle",
		flagPole = "the flag pole on the roof",
		outside = "the outside",
		secondCorridor = "the second floor corridor",
		art = "the art room",
		storage = "storage",
		math = "the math room",
		history = "history room",
		hall = "hall",
		music = "the music room",
		stage = "the stage at outside",
		thirdStairs = "the third floor stairs",
		cafe = "the café outside",
		decorations = "Decorations",
	},
	NL = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Snel, we hebben haast! De school moet zo snel mogelijk versierd worden! Stap in de doos en pak een voorwerp door op <vp>SPATIEBALK<n> te drukken!",
		itemTaken = "Neem een <vp>%s<n> en breng deze naar <vp>%s<n> alsjeblieft! Kom vervolgens terug naar de doos en pak een nieuw voorwerp!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Je hebt <j>%s<vp> ontvangen! Breng deze naar <j>%s<vp>, en kom vervolgens terug naar de lerarenkamer om een nieuw voorwerp te pakken!",
		alreadyHave = "<j>• [Event ^_^]<vp> Je hebt <j>%s<vp> al! Breng deze naar <j>%s<vp>, en kom vervolgens terug naar de lerarenkamer om een nieuw voorwerp te pakken!",
		wellDone = "<j>• [Event ^_^]<vp> Goed zo! Ga nu terug naar de lerarenkamer en pak een nieuw voorwerp!",
		endEvent = "<j>• [Event ^_^]<vp> Woo hoo! De leraar is trots op je! Fijne Kinderdag, muizen!",
		cheeseFlag = "vlag met kaas",
		octopus = "inktvis",
		flagString = "vlaggetjes",
		balloons = "ballonnen",
		kite = "vlieger",
		handPaint = "handverf",
		decor = "papieren poppetjes in een lijn",
		decor2 = "zonnebloem",
		decor3 = "papieren poppetjes in een cirkel",
		flagPole = "de vlaggenstok op het dak",
		outside = "buiten",
		secondCorridor = "de gang op de tweede verdieping",
		art = "kunstlokaal",
		storage = "opslagruimte",
		math = "wiskundelokaal",
		history = "geschiedenislokaal",
		hall = "hal",
		music = "muzieklokaal",
		stage = "het podium dat buiten staat",
		thirdStairs = "de trappen op de derde verdieping",
		cafe = "het café buiten",
		decorations = "decoraties",
	},
	SK= {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Rýchlo, musíme sa ponáhľať! Musíme vyzdobiť školu čo najrýchlešie, ako sa len dá! Choď ku krabici a stlač <vp>MEDZERNÍK<n> pre prevziatie dekorácie!",
		itemTaken = "Zober <vp>%s<n> <vp>%s<n> prosím! Potom sa vráť a vezmi ďaľšiu dekoráciu!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Dostal/a si <j>%s<vp>! Zober to <j>%s<vp> a potom sa vráť do učiteľského kabinetu pre ďaľšiu dekoráciu!",
		alreadyHave = "<j>• [Event ^_^]<vp> Už si dostal/a <j>%s<vp>! Zober to <j>%s<vp> a potom sa vráť do učiteľského kabinetu pre ďaľšiu dekoráciu!",
		wellDone = "<j>• [Event ^_^]<vp> Výborne! Teraz sa vráť do učiteľského kabinetu pre ďaľšiu dekoráciu!",
		endEvent = "<j>• [Event ^_^]<vp> Jéééj! Tvoja pani učiteľka je na teba veľmi hrdá! Šťastný Deň detí, myšičky!",
		cheeseFlag = "syrovú vlajku",
		octopus = "chobotnicu",
		flagString = "vlajky",
		balloons = "balóniky",
		kite = "šarkana",
		handPaint = "nafarbené ruky",
		decor = "reťaz s postavičkami",
		decor2 = "slnečnicu",
		decor3 = "kruh s postavičkami",
		flagPole = "na stĺp na vrchu budovy",
		outside = "von",
		secondCorridor = "na chodbu na druhom poschodí",
		art = "do účebne výtvarnej výchovy",
		storage = "do komory",
		math = "do účebne matematiky",
		history = "do účebne dejepisu",
		hall = "na chodbu",
		music = "do účebne hudobnej výchovy",
		stage = "von na pódium",
		thirdStairs = "na schody na treťom poschodí",
		cafe = "von do kaviarne",
		decorations = "Dekorácie",
	},
	PH = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Dali, kailangan nating magmadali! Kailangan na agad nating tapusing dekorasyonan ang eskuwelahan! Pumasok sa kahon at kumuha ng gamit sa pamamagamitan ng <vp>SPACE<n>!",
		itemTaken = "Pakidala niyang <vp>%s<n> sa <vp>%s<n>! Tapos bumalik at kumuha ng isa pang gamit!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Nakatanggap ka ng <j>%s<vp>! Dalhin ito sa <j>%s<vp>, tapos bumalik sa silid ng guro para kumuha ng isa pang gamit!",
		alreadyHave = "<j>• [Event ^_^]<vp> Mayroon ka ng <j>%s<vp>! Dalhin ito sa <j>%s<vp>, tapos bumalik sa silid ng guro para kumuha ng isa pang gamit!",
		wellDone = "<j>• [Event ^_^]<vp> Magaling! Ngayon bumalik ka na ulit sa silid ng guro para kumuha ng isa pang gamit!",
		endEvent = "<j>• [Event ^_^]<vp> Woo hoo! Proud na proud sa'yo ang guro mo! Happy Childrens Day, mga daga!",
		cheeseFlag = "watawat ng keso",
		octopus = "pugita",
		flagString = "pisi ng watawat",
		balloons = "mga lobo",
		kite = "saranggola",
		handPaint = "kamay pintura",
		decor = "kadenang papel na mga tao",
		decor2 = "mirasol",
		decor3 = "bilog na papel na mga tao",
		flagPole = "poste ng watawat",
		outside = "labas",
		secondCorridor = "koridor ng pangalwang palapag",
		art = "sining",
		storage = "bodega",
		math = "matematika",
		history = "kasaysayan",
		hall = "pasilyo",
		music = "musika",
		stage = "entablado",
		thirdStairs = "hagdan ng pangatlong palapag",
		cafe = "cafe",
		decorations = "mga dekorasyon",
	},
	BR = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Rápido, você precisa correr! Nós precisamos terminar de decorar a escola o mais rápido possível! Vá até a caixa e  pegue algum item pressionando <vp>ESPAÇO<n>!",
		itemTaken = "Leve o(a) <vp>%s<n> para o(a) <vp>%s<n> por favor! Então volte quando tudo estiver pronto para pegar outro item!",
		itemTaken2 = "<j>• [Evento ^_^]<vp> Você recebeu <j>%s<vp>! Leve isto para o(a) <j>%s<vp>, e então volte para a sala do professor (teacher's room) para pegar outro item!",
		alreadyHave = "<j>• [Evento ^_^]<vp> Você já tem <j>%s<vp>! Leve isto para <j>%s<vp>, e então volte para a sala do professor (teacher's room) para pegar outro item!",
		wellDone = "<j>• [Evento ^_^]<vp> Muito Bem! Agora volte para a sala do professor (teacher's room) novamente para pegar um novo item!",
		endEvent = "<j>• [Evento ^_^]<vp> Woo hoo! Seu professor está orgulhoso de você! Feliz Dia da Criança, ratinhos!",
		cheeseFlag = "bandeira de queijo",
		octopus = "polvo",
		flagString = "corda das bandeiras",
		balloons = "balões",
		kite = "pipa",
		handPaint = "pinturas à mão",
		decor = "bonecos de papel em fila",
		decor2 = "girassol",
		decor3 = "bonecos de papel em círculo",
		flagPole = "mastro da bandeiro no teto",
		outside = "lado de fora",
		secondCorridor = "corredor do segundo andar",
		art = "sala de arte (art)",
		storage = "armazém (storage)",
		math = "sala da matemática (maths)",
		history = "sala da história (history)",
		hall = "salão (hall)",
		music = "sala de música (music)",
		stage = "palco lá fora",
		thirdStairs = "escadas do terceiro andar",
		cafe = "café la fora",
		decorations = "Decorações",
	},
	DE = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Schnell, wir müssen uns beeilen! Wir müssen die Schule so schnell wie möglich fertig dekorieren! Geh in die Box und nimm einen Gegenstand, indem du die <vp>LEERTASTE<n> drückst!",
		itemTaken = "Trage das <vp>%s<n> bitte zu <vp>%s<n>! Dann komm zurück und nimm einen neuen Gegenstand!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Du hast <j>%s<vp> erhalten! Bring es zu <j>%s<vp>, dann geh zurück zum Lehrerzimmer und nimm einen neuen Gegenstand!",
		alreadyHave = "<j>• [Event ^_^]<vp> Du hast <j>%s<vp> schon! Bring es nach <j>%s<vp> und geh zurück ins Lehrerzimmer, um einen neuen Gegenstand aufzunehmen!",
		wellDone = "<j>• [Event ^_^]<vp> Gut gemacht! Geh nun zurück ins Lehrerzimmer, um einen neuen Gegenstand nehmen!",
		endEvent = "<j>• [Event ^_^]<vp> Woo hoo! Dein Lehrer ist stolz auf dich! Happy Childrens Day, Mäuse!",
		cheeseFlag = "Käseflagge",
		octopus = "Tintenfisch",
		flagString = "Fahnenleine",
		balloons = "Ballons",
		kite = "Drachen",
		handPaint = "Handzeichnungen",
		decor = "Papier Menschenkette",
		decor2 = "Sonnenblume",
		decor3 = "Papier Menschenkreis",
		flagPole = "Fahnenstange auf dem Dach",
		outside = "Draußen",
		secondCorridor = "Korridor im zweiten Stock",
		art = "Kunstzimmer",
		storage = "Lager",
		math = "Mathematik Zimmer",
		history = "Geschichtszimmer",
		hall = "Aula",
		music = "Musikzimmer",
		stage = "Die Bühne draußen",
		thirdStairs = "Treppe im dritten Stock",
		cafe = "Cafe draußen",
		decorations = "Dekorationen",
	},
	FR = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Vite! Nous devons nous dépêcher! Nous devons finir de décorer l'école le plus vite possible! Rentrez dans la boîte et prenez un item en pressant <vp>SPACE<n>!",
		itemTaken = "Prenez ça <vp>%s<n> pour <vp>%s<n> s'il vous plait! Puis revenez prendre un autre item!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Vous avez reçu <j>%s<vp>! Prenez le pour <j>%s<vp>, puis revenez dans la salle des professeurs pour prendre un autre item!",
		alreadyHave = "<j>• [Event ^_^]<vp> Vous avez déjà <j>%s<vp>! Prenez le pour <j>%s<vp>,puis revenez dans la salle des professeurs pour prendre un autre item!",
		wellDone = "<j>• [Event ^_^]<vp> Bravo! Maintenant revenez dans la salle des professeurs pour prendre un autre item!",
		endEvent = "<j>• [Event ^_^]<vp> Wouhou! Votre professeur est fier de vous! Joyeuse fête de l'Enfance, souris!",
		cheeseFlag = "drapeau de fromage",
		octopus = "poulpe",
		flagString = "chaîne de drapeaux",
		balloons = "ballons",
		kite = "cerf-volant",
		handPaint = "peintures faites à la main",
		decor = "chaîne de bonhommes en papier",
		decor2 = "tournesol",
		decor3 = "cercle de bonhommes en papier",
		flagPole = "mât du drapeau sur le toit",
		outside = "dehors",
		secondCorridor = "couloir du deuxième étage",
		art = "salle d'art",
		storage = "storage",
		math = "salle de mathématiques",
		history = "salle d'histoire",
		hall = "hall",
		music = "salle de musique",
		stage = "stade extérieur",
		thirdStairs = "escaliers du troisième étage",
		cafe = "cafe extérieur",
		decorations = "Décorations",
	},
	HU = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Gyorsan, sietnünk kell! Minél hamarabb be kell fejeznünk az iskola dekorálását! Siess a dobozhoz és vegyél fel egy dekorációt a <vp>SZÓKÖZ<n> megnyomásával!",
		itemTaken = "Vidd a <vp>%s<n> <vp>%s<n> kérlek! Azután gyere vissza egy másik dekorációért!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Felvettél egy <j>%s<vp>! Vidd <j>%s<vp>, aztán gyere vissza a tanári terembe egy másik dekorációért!",
		alreadyHave = "<j>• [Event ^_^]<vp> Az előbb vettél fel egy <j>%s<vp>! Vidd <j>%s<vp>, aztán gyere vissza a tanári terembe egy másik dekorációért!",
		wellDone = "<j>• [Event ^_^]<vp> Szép munka! Siess vissza a tanári terembe egy másik dekorációért!",
		endEvent = "<j>• [Event ^_^]<vp> Woo hoo! A tanárod büszke rád! Boldog Gyereknapot, egerek!",
		cheeseFlag = "sajt zászlót",
		octopus = "polipot",
		flagString = "zászló madzagot",
		balloons = "léggömböt",
		kite = "papírsárkányt",
		handPaint = "kéz festéket",
		decor = "papír ember láncot",
		decor2 = "napraforgót",
		decor3 = "papír ember kört",
		flagPole = "a zászlórúdhoz a tetőnél",
		outside = "odakint",
		secondCorridor = "a második emeleti folyosóhoz",
		art = "a művészeti terembe",
		storage = "a raktárba",
		math = "a matematika terembe",
		history = "a történelem terembe",
		hall = "a csarnokba",
		music = "a zene terembe",
		stage = "a színpadhoz odakint",
		thirdStairs = "a harmadik emeleti lépcsőhőz",
		cafe = "a kávézóhoz odakint",
		decorations = "Dekorációk",
	},
	LV = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Ātri, mums jāsteidzas! Jāpabeidz dekorēt skola pēc iespējas ātrāk! Dodies uz kasti un paņem kādu dekorāciju, spiežot atstarpi <vp>SPACE<n>!",
		itemTaken = "Aiznes <vp>%s<n> uz <vp>%s<n>, lūdzu! Tad nāc atpakaļ un paņem citu dekorāciju!",
		itemTaken2 = "<j>• [Pasākums ^_^]<vp>Tu esi saņēmis <j>%s<vp>! Aiznes to uz <j>%s<vp> un tad dodies atpakaļ uz skolotājas istabu, lai saņemtu jaunu dekorāciju!",
		alreadyHave = "<j>• [Pasākums ^_^]<vp> Tu jau esi paņēmis <j>%s<vp>! Aiznes to uz <j>%s<vp>, un tad dodies atpakaļ uz skolotājas istabu, lai saņemtu jaunu dekorāciju!",
		wellDone = "<j>• [Pasākums ^_^]<vp> Labi pastrādāts! Tagad dodies atpakaļ uz skolotājas istabu, lai paņemtu jaunu!",
		endEvent = "<j>• [Pasākums ^_^]<vp> Woo hoo! Tava skolotāja lepojas ar Tevi! Priecīgu Starptautisko bērnu aizsardzības dienu, pele!",
		cheeseFlag = "siera karogu",
		octopus = "astoņkāji",
		flagString = "karogu virtenes",
		balloons = "balonu",
		kite = "pūķi",
		handPaint = "roku krāsas",
		decor = "papīra cilvēciņu virteni",
		decor2 = "saulespuķi",
		decor3 = "papīra cilvēciņu apli",
		flagPole = "karoga masts uz jumta",
		outside = "ārā",
		secondCorridor = "otrā stāva gaiteni",
		art = "vizuālās mākslas klasi",
		storage = "noliktavu",
		math = "matemātikas klasi",
		history = "vēstures klasi",
		hall = "halli",
		music = "mūzikas klasi",
		stage = "āra skatuvi",
		thirdStairs = "trešā stāva kāpnēm",
		cafe = "āra kafejnīcu",
		decorations = "Dekorācijas",
	},
	PL = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Szybko, pospieszmy się! Musimy jak najszybciej skończyć dekorowanie szkoły! Podejdź do pudełka i podnieś przedmiot wciskając <vp>SPACJĘ<n>!",
		itemTaken = "Zanieś <vp>%s<n> do/na <vp>%s<n>, proszę! Potem wróć i weź kolejną rzecz!",
		itemTaken2 = "<j>• [Event ^_^]<vp>  Otrzymałeś/aś <j>%s<vp>! Zanieś to do/na <j>%s<vp>, a potem wróć do pokoju nauczycielskiego po więcej przedmiotów!",
		alreadyHave = "<j>• [Event ^_^]<vp> Posiadasz już <j>%s<vp>! Zanieś to do/na <j>%s<vp>, a potem wróć do pokoju nauczycielskiego po więcej przedmiotów!",
		wellDone = "<j>• [Event ^_^]<vp> Brawo! Teraz wróć do pokoju nauczycielskiego po kolejny przedmiot!",
		endEvent = "<j>• [Event ^_^]<vp> Jupi! Wasz nauczyciel jest z Was dumny! Wesołego Międzynarodowego Dnia Dziecka, myszki!",
		cheeseFlag = "serowa flagę",
		octopus = "ośmiornicę",
		flagString = "łańcuch z flagami",
		balloons = "balony",
		kite = "latawiec",
		handPaint = "ręczne malowidło",
		decor = "łańcuch papierowych ludzików",
		decor2 = "słonecznik",
		decor3 = "wycicnankę z papieru",
		flagPole = "maszt flagi na dachu",
		outside = "na zewnątrz",
		secondCorridor = "korytarz na drugim piętrze",
		art = "sali plastycznej",
		storage = "schowka",
		math = "sali matematycznej",
		history = "sali historycznej",
		hall = "holu",
		music = "sali muzycznej",
		stage = "scenę na zewnątrz",
		thirdStairs = "schody na trzecim piętrze",
		cafe = "kawiarnii na zewnątrz",
		decorations = "Dekoracje",
	},
	TR = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Çabuk, acele etmemiz gerekiyor! Mümkün olduğu kadar kısa sürede okulu süslememiz gerekiyor! Kutunun içine gidin ve <vp>BOŞLUK<n> tuşuna basarak eşyayı alın!",
		itemTaken = "Lütfen <vp>%s<n> eşyasını <vp>%s<n> götürün! Sonra başka bir eşya almak için geri dönün!",
		itemTaken2 = "<j>•  [Etkinlik ^_^]<vp> <j>%s<vp> eşyasını aldınız!  <j>%s<vp> götürün, ve başka bir eşya almak için Öğretmenler Odasına geri dönün!",
		alreadyHave = "<j>•  [Etkinlik ^_^]<vp> Zaten <j>%s<vp> eşyasına sahipsin! <j>%s<vp> götürün, ve başka bir eşya almak için Öğretmenler Odasına geri dönün!",
		wellDone = "<j>• [Etkinlik ^_^]<vp> Tebrikler! Şimdi başka bir eşya almak için Öğretmenler Odasına geri gidin!",
		endEvent = "<j>• [Event ^_^]<vp> Vuu huu! Öğretmeniniz sizinle gurur duyuyor! Çocuk Bayramınız kutlu olsun, faredaşlar!",
		cheeseFlag = "Peynir bayrağı",
		octopus = "Ahtapot",
		flagString = "Bayrak şeritleri",
		balloons = "Balonlar",
		kite = "Uçurtma",
		handPaint = "El boyaları",
		decor = "Kağıt adam zinciri",
		decor2 = "Ayçiçeği",
		decor3 = "Kağıt adam dairesi",
		flagPole = "çatı katındaki bayrak direğine",
		outside = "dışarıya",
		secondCorridor = "ikinci katın koridoruna",
		art = "sanat odasına",
		storage = "depoya",
		math = "matematik sınıfına",
		history = "tarih sınıfına",
		hall = "hole",
		music = "müzik sınıfına",
		stage = "dışarıdaki sahneye",
		thirdStairs = "üçüncü kat merdivenlerine",
		cafe = "dışarıdaki kafeye",
		decorations = "Süslemeler",
	},
	IT = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Svelto, dobbiamo affrettarci! Dobbiamo finire di decorare la scuola il prima possibile! Vai nella scatola e prendi un oggetto usando <vp>SPACE<n>",
		itemTaken = "Porta quel <vp>%s<n> in <vp>%s<n> per favore! Poi torna a prendere un altro oggetto!",
		itemTaken2 = "<j>• [Evento ^_^]<vp> Hai ricevuto <j>%s<vp>! Portalo in <j>%s<vp>, e poi torna indietro nella sala professori per prendere un altro oggetto!",
		alreadyHave = "<j>• [Evento ^_^]<vp> Hai già <j>%s<vp>! Portalo in <j>%s<vp>, e poi torna indietro nella sala professori per prendere un altro oggetto!",
		wellDone = "<j>• [Evento ^_^]<vp> Ben fatto! Ora torna di nuovo nella sala professori per prendere un altro oggetto!",
		endEvent = "<j>• [Evento ^_^]<vp> Woo hoo! Il vostro professore è fiero di voi! Felice Children's Day, topi!",
		cheeseFlag = "bandiera formaggio",
		octopus = "polpo",
		flagString = "striscioni",
		balloons = "palloncini",
		kite = "aquilone",
		handPaint = "colori a dita",
		decor = "catena di omini di carta",
		decor2 = "girasole",
		decor3 = "cerchio di omini di carta",
		flagPole = "Palo portabandiera sul tetto",
		outside = "fuori",
		secondCorridor = "corridoio del secondo piano",
		art = "aula di arte",
		storage = "magazzino",
		math = "aula di matematica",
		history = "aula di storia",
		hall = "ingresso",
		music = "aula dimusica",
		stage = "il palco all'esterno",
		thirdStairs = "scale del terzo piano",
		cafe = "cafè all'esterno",
		decorations = "Decorazioni",
	},
	RO = {
		teacherIntro = "Repede, trebuie să ne grăbim! Trebuie să terminăm de decorat școala cât mai rapid posibil! Intră în cutie și ridică un articol cu ajutorul tastei <vp>SPAȚIU<n>!",
		itemTaken = "Te rog du %s<n> %s<n>! Apoi revino și ridică alt articol!",
		itemTaken2 = "<j>• [Eveniment ^_^]<vp> Ai primit <j>%s<vp>! Du articolul <j>%s<vp>, apoi revino în sala profesorului pentru a ridica altul!",
		alreadyHave = "<j>• [Eveniment ^_^]<vp> Ai deja <j>%s<vp>! Du articolul <j>%s<vp>,  apoi revino în sala profesorului pentru a ridica altul!",
		wellDone = "<j>• [Eveniment ^_^]<vp> Bună treabă! Acum întoarce-te în sala profesorului pentru a ridica alt articol!",
		endEvent = "<j>• [Eveniment ^_^]<vp> Woo hoo! Profesorul vostru este mândru de voi! Să aveți o Zi a Copilului fericită, șoricei!",
		cheeseFlag = "acel <vp>steag cu simbolul brânzei",
		octopus = "acea <vp>caracatiță",
		flagString = "acele <vp>corzi pentru steaguri",
		balloons = "acele <vp>baloane",
		kite = "acel <vp>zmeu",
		handPaint = "acea <vp>vopsea de mână",
		decor = "acel <vp>lanț din oameni de hârtie",
		decor2 = "acea <vp>floare a soarelui",
		decor3 = "acel <vp>cerc din oameni de hârtie",
		flagPole = "la <vp>suportul de steag de pe acoperiș",
		outside = "<vp>afară",
		secondCorridor = "în <vp>coridorul celui de al doilea etaj",
		art = "în <vp>sala de artă",
		storage = "în <vp>depozit",
		math = "în <vp>sala de matematică",
		history = "în <vp>sala de istorie",
		hall = "pe <vp>coridor",
		music = "în <vp>sala de muzică",
		stage = "pe <vp>scena de afară",
		thirdStairs = "pe <vp>scările celui de al treilea etaj",
		cafe = "la <vp>cafeneaua de afară",
		decorations = "Decorațiuni",
	},
	JP = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "学校の装飾をできるだけ早急に仕上げるんだ! この箱の中に入って <vp>スペースキー<n> を押してアイテムを取るのだ! さあ急げ!",
		itemTaken = "その <vp>%s<n> は <vp>%s<n> へ持って行ってくれ! そうしたら次のアイテムを取りに戻ろう!",
		itemTaken2 = "<j>• [Event ^_^]<vp> <j>%s<vp> を取った! それを <j>%s<vp> へ持って行こう、そして次のアイテムを取りに先生の部屋に戻ろう!",
		alreadyHave = "<j>• [Event ^_^]<vp> まだ <j>%s<vp> を持ってるよ! それを <j>%s<vp> へ持って行こう、そして次のアイテムを取りに先生の部屋に戻ろう!",
		wellDone = "<j>• [Event ^_^]<vp> よくやった! すぐに次のアイテムを取りに先生の部屋に戻ろう!",
		endEvent = "<j>• [Event ^_^]<vp> 素晴らしい! 君たちの働きに先生は誇りを持てます! 皆さん, Happy Children's Day!",
		cheeseFlag = "チーズ旗",
		octopus = "タコ",
		flagString = "万国旗",
		balloons = "風船",
		kite = "凧",
		handPaint = "ハンドペイント",
		decor = "手つなぎ切り紙人形",
		decor2 = "ひまわり",
		decor3 = "切り紙人形の輪",
		flagPole = "屋根の旗ポール",
		outside = "外",
		secondCorridor = "二階の廊下",
		art = "美術室",
		storage = "保管庫",
		math = "数学室",
		history = "歴史室",
		hall = "玄関",
		music = "音楽室",
		stage = "外のステージ",
		thirdStairs = "三階の階段",
		cafe = "外のカフェ",
		decorations = "飾られた数",
	},
	ID = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Cepat, kita perlu bergegas! Kita harus selesai mendekorasi sekolah secepat mungkin! Pergilah ke kotak dan ambillah sebuah benda dengan menekan <vp>SPASI<n>!",
		itemTaken = "Tolong bawa <vp>%s<n> ke <vp>%s<n>! Lalu kembalilah untuk mengambil benda lain!",
		itemTaken2 = "<j>• [Acara ^_^]<vp> Anda telah menerima <j>%s<vp>! Bawalah ke <j>%s<vp>, lalu pergilah kembali ke ruang guru untuk mengambil benda lain!",
		alreadyHave = "<j>• [Acara ^_^]<vp> Anda sudah mempunyai <j>%s<vp>! Bawalah ke <j>%s<vp>, lalu pergilah kembali ke ruang guru untuk mengambil benda lain!",
		wellDone = "<j>• [Acara ^_^]<vp> Kerja yang baik! Sekarang pergilah kembali ke ruang guru untuk mengambil benda lain!",
		endEvent = "<j>• [Acara ^_^]<vp> Hore! Guru Anda bangga akan Anda! Selamat Hari Anak, tikus-tikus!",
		cheeseFlag = "bendera keju",
		octopus = "gurita",
		flagString = "tali bendera",
		balloons = "balon",
		kite = "layang-layang",
		handPaint = "cat tangan",
		decor = "rantai orang dari kertas",
		decor2 = "bunga matahari",
		decor3 = "lingkaran orang dari kertas",
		flagPole = "tiang bendera di atap",
		outside = "luar",
		secondCorridor = "koridor lantai dua",
		art = "ruang seni",
		storage = "gudang",
		math = "ruang matematika",
		history = "ruang sejarah",
		hall = "aula",
		music = "ruang musik",
		stage = "panggung di luar",
		thirdStairs = "tangga lantai tiga",
		cafe = "kafe di luar",
		decorations = "Dekorasi",
	},
	LT = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Greičiau, mes turime paskubėti! Mes turime baigti dekoruoti mokyklą kaip tik įmanoma greičiau! Nueik iki dėžės ir paimk daiktą spausdamas <vp>SPACE<n>!",
		itemTaken = "Paimk tai <vp>%s<n> to <vp>%s<n> prašau! Tada sugrįžk ir paimk kitą daiktą!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Tu gavai <j>%s<vp>! Nunešk tai <j>%s<vp>, ir tada grįžk į mokytojo kambarį, kad paimtum kitą daiktą!",
		alreadyHave = "<j>• [Event ^_^]<vp> Tu jau turi <j>%s<vp>! Nunešk tai <j>%s<vp>, ir tada grįžk į mokytojo kambarį, kad paimtum kitą daiktą!",
		wellDone = "<j>• [Event ^_^]<vp> Puikiai atlikta! Dabar vėl grįžk į mokytojo kambarį, kad paimtum kitą daiktą!",
		endEvent = "<j>• [Event ^_^]<vp> Woo hoo! Tavo mokytojas tavimi didžiuojasi! Su Vaikų diena, peliukai!",
		cheeseFlag = "sūrio vėliava",
		octopus = "aštuonkojis",
		flagString = "vėliavos virvutė",
		balloons = "balionai",
		kite = "aitvaras",
		handPaint = "rankų dažai",
		decor = "popierinių žmonių girlianda",
		decor2 = "saulėgrąža",
		decor3 = "popierinių žmonių apskritimas",
		flagPole = "vėliavos stiebas ant stogo",
		outside = "laukas",
		secondCorridor = "antro aukšto koridorius",
		art = "menų kambarys",
		storage = "sandėlys",
		math = "matematikos kabinetas",
		history = "istorijos kabinetas",
		hall = "salė",
		music = "muzikos kabinetas",
		stage = "lauke esanti scena",
		thirdStairs = "trečio aukšto laiptai",
		cafe = "lauko kavinė",
		decorations = "Dekoracijos",
	},
	ES = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "¡Rápido, hay que darse prisa! ¡Tenemos que terminar de decorar el colegio tan pronto como sea posible! ¡Ve a la caja y recoge un objeto presionando <vp>ESPACIO<n>!",
		itemTaken = "¡Lleva <vp>%s<n> a <vp>%s<n> por favor! ¡Luego vuelve para recoger otro objeto!",
		itemTaken2 = "<j>• [Evento ^_^] ¡<vp>Has recibido <j>%s<vp>! ¡Llévalo a <j>%s<vp>, y luego vuelve a la sala de profesores para recoger otro objeto!",
		alreadyHave = "<j>• [Evento ^_^] ¡<vp>Ya tienes <j>%s<vp>! ¡Llévalo a <j>%s<vp>, y luego vuelve a la sala de profesores para recoger otro objeto!",
		wellDone = "<j>• [Evento ^_^]<vp> ¡Bien hecho! ¡Ahora vuelve a la sala de profesores otra vez para recoger otro objeto!",
		endEvent = "<j>• [Evento ^_^]<vp> ¡Woo hoo! ¡Vuestro profesor está orgulloso de vosotros! ¡Feliz Día del Niño, ratoncitos!",
		cheeseFlag = "bandera de queso",
		octopus = "pulpo",
		flagString = "cuerdas de bandera",
		balloons = "globos",
		kite = "cometa",
		handPaint = "pintura de manos",
		decor = "cadena de gente de papel",
		decor2 = "girasol",
		decor3 = "círculo de gente de papel",
		flagPole = "mástil de la bandea del tejado",
		outside = "fuera",
		secondCorridor = "pasillo del segundo piso",
		art = "sala de arte",
		storage = "almacén",
		math = "sala de matemáticas",
		history = "sala de historia",
		hall = "vestíbulo",
		music = "sala de música",
		stage = "escenario del exterior",
		thirdStairs = "escaleras del tercer piso",
		cafe = "café del exterior",
		decorations = "Decoraciones",
	},
	VK= {
		-- Feel free to translate "Begivenhet" in the tags
		teacherIntro = "Vi må skynde oss! Vi må fullføre dekoreringen av skolen så fort som mulig! Gå til boksen og plukk opp en gjenstand ved å trykke på <vp>MELLOMROM <n>!",
		itemTaken = "Ta den <vp>%s<n> til <vp>%s<n> vær så snill! Etterpå må du komme tilbake og hente en annen gjenstand!",
		itemTaken2 = "<j>• [Begivenhet ^_^]<vp> Du har motatt <j>%s<vp>! Ta den til <j>%s<vp>, og kom tilbake for å plukke opp en annen gjenstand!",
		alreadyHave = "<j>• [Begivenhet ^_^]<vp> Du har allerede <j>%s<vp>! Ta den til <j>%s<vp>, og kom tilbake for å plukke opp en annen gjenstand!",
		wellDone = "<j>• [Begivenhet ^_^]<vp> Godt jobbet! Gå tilbake til lærerværelse og plukk opp en annen gjenstand!",
		endEvent = "<j>• [Begivenhet^_^]<vp> Woo hoo! Læreren din er stolt over deg! Ha en fin dag(Begivenheten er laget for å feire barnas dag I Tyrkia)! ",
		cheeseFlag = "osteflagg",
		octopus = "blekksprut",
		flagString = "flagg",
		balloons = "ballonger",
		kite = "drage",
		handPaint = "håndmaling",
		decor = "paperirkunst",
		decor2 = "solsikke",
		decor3 = "papirkunstsirkel ",
		flagPole = "flaggstang på taket",
		outside = "ute",
		secondCorridor = "andre etasje korridor ",
		art = "kunstrom",
		storage = "lager",
		math = "matterom",
		history = "historierom",
		hall = "gang",
		music = "musikkrom ",
		stage = "Utescenen",
		thirdStairs = "tredje etasje trappene",
		cafe = "café på utsiden",
		decorations = "Dekorasjoner",
	},
	CZ = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Rychle, musíme si pospíšit! Musíme vyzdobit školu co nejrychleji! Jdi ke krabici a stiskni <vp>MEZERNÍK<n> pro převzetí dekorace!",
		itemTaken = "Vem <vp>%s<n> <vp>%s<n> prosím! Pak se vrať a vem další dekoraci!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Dostal/a si <j>%s<vp>! Vem to <j>%s<vp> a pak se vrať do učitelského kabinetu pro další dekoraci!",
		alreadyHave = "<j>• [Event ^_^]<vp> Už jsi dostal/a <j>%s<vp>! Vem to <j>%s<vp> a pak se vrať do učitelského kabinetu pro další dekoraci!",
		wellDone = "<j>• [Event ^_^]<vp> Výborně! Teď se vrať do učitelského kabinetu pro další dekoraci!",
		endEvent = "<j>• [Event ^_^]<vp> Jeeej! Tvá paní učitelka je na tebe velmi hrdá! Veselý Den dětí, myšky!",
		cheeseFlag = "sýrovou vlajku",
		octopus = "chobotnici",
		flagString = "vlajky",
		balloons = "balóny",
		kite = "draka",
		handPaint = "zabarvené ruce",
		decor = "řetěz s postavami",
		decor2 = "slunečnici",
		decor3 = "kruhovou řetěz s postavami",
		flagPole = "na tyč na střeše",
		outside = "ven",
		secondCorridor = "na chodbu ve druhém patře",
		art = "do učebny výtvarné výchovy",
		storage = "do skladu",
		math = "do učebny matematiky",
		history = "do učebny dějepisu",
		hall = "na chodbu",
		music = "do učebny hudební výchovy",
		stage = "ven na jeviště",
		thirdStairs = "na schody na třetím patře",
		cafe = "ven do kavárny",
		decorations = "Dekorace",
	},
	RU = {
		teacherIntro = "Быстрее! Нам нужно спешить! Мы должны украсить школу как можно скорее! Зайди в коробку и возьми предмет, нажав <vp>SPACE<n>!",
		itemTaken = "Отнеси <vp>%s<n> в <vp>%s<n>, пожалуйста! Затем вернись, чтобы взять другой предмет!",
		itemTaken2 = "<j>• [Event ^_^]<vp> Ты взял <j>%s<vp>! Отнеси эту вещь в <j>%s<vp>, затем вернись в учительскую, чтобы взять другой предмет!",
		alreadyHave = "<j>• [Event ^_^]<vp> У тебя уже есть <j>%s<vp>! Отнеси эту вещь в <j>%s<vp>, затем вернись в учительскую, чтобы взять другой предмет!",
		wellDone = "<j>• [Event ^_^]<vp> Молодец! А теперь снова вернись в учительскую, чтобы взять другой предмет!",
		endEvent = "<j>• [Event ^_^]<vp> Ура! Твой учитель гордится тобой! Со Всемирным Днем детей, мышки!",
		cheeseFlag = "сырное знамя",
		octopus = "осьминог",
		flagString = "флажки",
		balloons = "воздушные шары",
		kite = "воздушный змей",
		handPaint = "отпечатки рук",
		decor = "бумажные человечки",
		decor2 = "подсолнух",
		decor3 = "бумажный хоровод",
		flagPole = "флагшток",
		outside = "снаружи",
		secondCorridor = "коридор на втором этаже",
		art = "изостудия",
		storage = "хранилище",
		math = "кабинет математики",
		history = "кабинет истории",
		hall = "зал",
		music = "кабинет музыки",
		stage = "сцена",
		thirdStairs = "лестница на третий этаж",
		cafe = "кафе",
		decorations = "Украшения",
	},
	FI = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "Äkkiä, meidän täytyy kiirehtiä! Meidän täytyy viimeistellä koulun koristelu niin pian kuin mahdollista! Mene laatikkoon ja kerää esine painamalla <vp>VÄLILYÖNTIÄ<n>!",
		itemTaken = "Vie <vp>%s<n> <vp>%s<n> ole hyvä! Tule sitten takaisin keräämään toinen tavara!",
		itemTaken2 = "<j>• [Event ^_^] <vp> Olet kerännyt <j>%s<vp>! Vie se <j>%s<vp>, ja tule takaisin opettajan huoneeseen keräämään toinen esine!",
		alreadyHave = "<j>• [Event ^_^] <vp> Sinulla on jo <j>%s<vp>! Vie se <j>%s<vp>, ja tule takaisin opettajan huoneeseen keräämään toinen tavara!",
		wellDone = "<j>• [Event ^_^]<vp> Hienosti tehty! Nyt mene takaisin opettajan huoneeseen uudestaan kerämään toinen tavara!",
		endEvent = "<j>• [Event ^_^]<vp> Jee! Sinun opettajasi on ylpeä sinusta! Hyvää lasten päivää, hiiret!",
		cheeseFlag = "juustolippu",
		octopus = "mustekala",
		flagString = "lippunauhat",
		balloons = "ilmapallot",
		kite = "leija",
		handPaint = "sormivärit",
		decor = "paperinen ihmisnauha",
		decor2 = "auringonkukka",
		decor3 = "paperinen ihmisympyrä",
		flagPole = "lipputanko katossa",
		outside = "ulkona",
		secondCorridor = "toisen kerroksen käytävä",
		art = "taidehuone",
		storage = "varasto",
		math = "matematiikan luokka",
		history = "historian luokka",
		hall = "käytävä ",
		music = "musiikin luokka",
		stage = "lava ulkona",
		thirdStairs = "kolmannen kerroksen portaat",
		cafe = "kahvila ulkona",
		decorations = "Koristelut",
	},
	CN = {
		-- Feel free to translate "Event" in the tags
		teacherIntro = "快, 我们需要冲! 我们需要尽早完成学校的装饰! 前往箱子并拾起物品按 <vp>空格键<n>!",
		itemTaken = "拿着 <vp>%s<n> 到 <vp>%s<n> 请! 然后回来捡起另一件物品!",
		itemTaken2 = "<j>• [Event ^_^]<vp> 你已经收到 <j>%s<vp>! 把它置于 <j>%s<vp>, 然后回到老师的教室拾起另外的物品!",
		alreadyHave = "<j>• [Event ^_^]<vp> 你已经拥有 <j>%s<vp>! 把它置于 <j>%s<vp>, 然后回到老师的教室拾起另外的物品!",
		wellDone = "<j>• [Event ^_^]<vp> 非常好!现在再次回到老师的教室拾起另外的物品!",
		endEvent = "<j>• [Event ^_^]<vp> Woo hoo! 你的老师为你感到骄傲! 儿童节快乐, 小老鼠!",
		cheeseFlag = "奶酪旗",
		octopus = "章鱼",
		flagString = "串旗",
		balloons = "气球",
		kite = "风筝",
		handPaint = "油漆手印",
		decor = "纸人链",
		decor2 = "向日葵",
		decor3 = "纸人圈",
		flagPole = "屋顶的旗杆",
		outside = "外边",
		secondCorridor = "二楼走廊",
		art = "艺术室",
		storage = "储藏室",
		math = "数学室",
		history = "史学室",
		hall = "大堂",
		music = "音乐室",
		stage = "台阶的外边",
		thirdStairs = "三楼的楼梯",
		cafe = "cafe的外边",
		decorations = "装饰品",
	},
}

translations.XX = translations.TR

COMMUNITY = (tfm.get.room.community or "xx"):upper()

function translate(what, line)
	if line then
		return translations[COMMUNITY][what][line] or translations.XX[what][line] or "no translation"
	else
		return translations[COMMUNITY][what] or translations.XX[what] or "no translation"
	end
end

-- VARIABLES --
xml = [[<C><P H="905" L="3700" /><Z><S><S L="3000" X="1500" H="20" Y="900" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="35" X="182" H="70" Y="876" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="60" H="65" X="266" Y="863" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" H="60" X="339" Y="874" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" X="410" H="60" Y="874" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="60" H="60" X="494" Y="861" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" X="566" H="60" Y="874" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" X="634" H="60" Y="874" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="60" X="720" H="60" Y="860" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" H="60" X="791" Y="878" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" H="60" X="860" Y="878" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="60" H="60" X="943" Y="863" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" H="60" X="1017" Y="880" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="130" H="10" X="1118" Y="823" T="12" P="0,0,0.5,0.2,0,0,0,0" /><S L="290" X="1524" H="10" Y="854" T="12" P="0,0,0.5,0.2,0,0,0,0" /><S L="25" H="385" X="1932" Y="641" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="160" H="30" X="2003" Y="463" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" X="2070" H="120" Y="420" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="250" X="2180" H="30" Y="371" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="28" H="100" X="2320" Y="336" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="545" H="25" X="2579" Y="292" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="320" H="25" X="3160" Y="292" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" X="3305" H="80" Y="332" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="275" X="3433" H="20" Y="361" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="25" H="145" X="3565" Y="425" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="145" H="50" X="3625" Y="471" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="25" H="462" X="3691" Y="677" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="750" X="2298" H="20" Y="490" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="920" X="3220" H="20" Y="490" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="890" X="2372" H="13" Y="696" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="750" H="13" X="3322" Y="699" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="30" H="125" X="3569" Y="773" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="20" X="2069" H="158" Y="570" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="20" X="2856" H="180" Y="771" T="12" P="0,0,0.3,0.2,45,0,0,0" /><S L="10" X="2792" H="10" Y="836" T="13" P="0,0,0.3,0.2,0,0,0,0" /><S L="20" H="190" X="2720" Y="565" T="12" P="0,0,0.1,0.2,-35,0,0,0" /><S L="10" H="10" X="2832" Y="436" T="13" P="0,0,1,0.2,0,0,0,0" /><S L="1780" H="25" X="2809" Y="894" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="75" H="10" X="1884" Y="892" T="12" P="0,0,0.3,0.2,-10,0,0,0" /><S L="20" X="2065" H="135" Y="770" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="25" H="135" X="3020" Y="568" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="10" X="2938" H="130" Y="767" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="20" H="245" X="2729" Y="163" T="9" m="" P="0,0,,,,0,0,0" /><S L="154" X="3112" H="15" Y="786" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="134" H="15" X="3293" Y="757" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="293" H="15" X="2293" Y="832" T="12" P="0,0,1,0.2,0,0,0,0" /><S L="175" X="3127" H="30" Y="470" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="130" X="3123" H="30" Y="445" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="210" X="2500" H="30" Y="460" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="10" X="3011" H="60" Y="873" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="10" H="60" X="3081" Y="873" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="150" X="1095" H="12" Y="890" T="12" P="0,0,0.5,0.2,5,0,0,0" /><S L="330" H="20" X="1523" Y="874" T="12" P="0,0,0.5,0.2,0,0,0,0" /><S L="10" H="10" X="2778" Y="647" T="13" P="0,0,1,0.2,0,0,0,0" /><S L="20" X="2922" H="220" Y="359" T="12" P="0,0,0.1,0.2,50,0,0,0" /><S L="40" X="3355" H="10" Y="835" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="20" X="3408" H="10" Y="846" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="235" X="3357" H="10" Y="640" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="155" X="3580" H="10" Y="587" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="210" X="3357" H="10" Y="550" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="204" X="2395" H="10" Y="626" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="185" X="2397" H="10" Y="542" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="135" X="2183" H="10" Y="573" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S L="73" X="1116" H="10" Y="753" T="12" P="0,0,1.0,0.2,0,0,0,0" /><S c="3" L="300" X="1522" H="10" Y="618" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S c="3" L="10" X="1403" H="210" Y="694" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S c="3" L="10" X="1651" H="210" Y="697" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S c="3" L="120" X="1418" H="10" Y="638" T="12" P="0,0,0.3,0.2,-40,0,0,0" /><S c="3" L="130" X="1618" H="10" Y="639" T="12" P="0,0,0.3,0.2,40,0,0,0" /><S c="3" L="10" H="115" X="1745" Y="775" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S c="3" L="10" H="115" X="1288" Y="775" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S c="3" L="75" X="1292" H="10" Y="731" T="12" P="0,0,0.3,0.2,-40,0,0,0" /><S c="3" L="75" X="1748" H="10" Y="731" T="12" P="0,0,0.3,0.2,40,0,0,0" /><S c="3" L="28" X="1322" H="23" Y="722" T="12" P="0,0,0.3,0.2,50,0,0,0" /><S c="3" L="28" X="1717" H="23" Y="722" T="12" P="0,0,0.3,0.2,-40,0,0,0" /><S L="10" H="61" X="3497" Y="808" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="43" H="36" X="3500" Y="777" T="12" P="0,0,0.3,0.2,50,0,0,0" /></S><D><DS Y="865" X="3232" /></D><O /></Z></C>]]

players = {}

items = {
	{
		name_id = "cheeseFlag", -- Cheese Flag
		images = {"14cd2968b97.png", "14cd296ab7f.png"},
		room = translate("flagPole"),
		x = {2732-40, 2732},
		y = {81, 81},
		size = {132,102}
	},
	{
		name_id = "octopus", -- boy
		images = {"14cd2aee85c.png", "14cd2af1861.png"},
		room = translate("outside"),
		x = {1748, 1748},
		y = {733-50, 841},
		size = {100,149}
	},
	{
		name_id = "octopus", -- girl
		images = {"14cd2af59d4.png", "14cd2af7f2b.png"},
		room = translate("outside"),
		x = {1300, 1300},
		y = {733-50, 841},
		size = {100,149}
	},
	{
		name_id = "flagString", -- 1
		images = {"14cd2a76473.png", "14cd2a78e73.png"},
		room = translate("stage"),
		x = {1515, 1515},
		y = {675, 801},
		size = {271,105}
	},
	{
		name_id = "flagString", -- 3
		images = {"14cd2a740f7.png", "14cd2a7d8dc.png"},
		room = translate("stage"),
		x = {1515, 1515},
		y = {700, 801},
		size = {271,105}
	},
	{
		name_id = "flagString", -- 2
		images = {"14cd2a7256f.png", "14cd2a7b950.png"},
		room = translate("stage"),
		x = {1515, 1515},
		y = {725, 801},
		size = {271,105}
	},
	{
		name_id = "balloons", -- Pink
		images = {"14cd2b06098.png", "14cd29644fc.png"},
		room = translate("outside"),
		x = {167, 167},
		y = {821-90, 821},
		size = {100,149}
	},
	{
		name_id = "balloons",  -- OrangeBlue
		images = {"14cd2b043fd.png", "14cd292d240.png"},
		room = translate("outside"),
		x = {353, 353},
		y = {822-90, 822},
		size = {100,149}
	},
	{
		name_id = "balloons",  -- Orange
		images = {"14cd2b0012c.png", "14cd29584ba.png"},
		room =  translate("outside"),
		x = {584, 584},
		y = {814-90, 814},
		size = {100,149}
	},
	{
		name_id = "balloons",  -- YellowViolet
		images = {"14cd2b17c47.png", "14cd2950bd4.png"},
		room = translate("outside"),
		x = {808, 808},
		y = {820-90, 820},
		size = {100,149}
	},

	{
		name_id = "balloons", -- Yellow
		images = {"14cd2b163b1.png", "14cd2952f43.png"},
		room = translate("outside"),
		x = {847, 847},
		y = {820-90, 820},
		size = {100,149}
	},
	{
		name_id = "kite", -- PinkBlue
		images = {"14cd2b0e0d2.png", "14cd2aeac04.png"},
		room = translate("secondCorridor"),
		x = {2864, 2864},
		y = {629, 629},
		size = {129,113}
	},
	{
		name_id = "kite", -- OrangeViolet
		images = {"14cd2b0b971.png", "14cd2ae8bed.png"},
		room = translate("thirdStairs"),
		x = {2856, 2856},
		y = {347, 347},
		size = {129,113}
	},
	{
		name_id = "handPaint", -- BlueOrange
		images = {"14cd2abb5ab.png", "14cd2adbbb4.png"},
		room = translate("hall"),
		x = {2648, 2648},
		y = {828, 828},
		size = {68,62}
	},
	{
		name_id = "handPaint", --  PurpleYellow
		images = {"14cd2ac0336.png", "14cd2ad80dd.png"},
		room = translate("storage"),
		x = {3628, 3628},
		y = {810, 810},
		size = {68,62}
	},
	{
		name_id = "handPaint", -- PinkGreen
		images = {"14cd2ac1ec7.png", "14cd2ad5e60.png"},
		room = translate("art"),
		x = {2739, 2739},
		y = {402, 402},
		size = {68,62}
	},
	{
		name_id = "decor", -- 4 people string
		images = {"14cd29787ef.png","14cd29a4895.png"},
		room = translate("cafe"),
		x = {1112, 1112},
		y = {847, 802},
		size = {160,81}
	},
	{
		name_id = "decor", -- 2 people string
		images = {"14cd2984fe1.png","14cd297acd9.png"},
		room = translate("math"),
		x = {3575, 3575},
		y = {582+33, 582},
		size = {129,78}
	},
	{
		name_id = "decor", -- 4 people
		images = {"14cd298061e.png","14cd297ce31.png"},
		room = translate("hall"),
		x = {2355, 2355},
		y = {809-3, 809},
		size = {129,69}
	},
	{
		name_id = "decor", -- 2 people
		images = {"14cd2987262.png","14cd2de0ee2.png"},
		room = translate("storage"),
		x = {3442, 3442},
		y = {465-5,465},
		size = {83,69}
	},
	{
		name_id = "decor2", -- Sun Thing(?)
		images = {"14cd298d961.png","14cd29a8ee7.png"},
		room = translate("history"),
		x = {2400, 2400},
		y = {540, 638},
		size = {83,72}
	},
	{
		name_id = "decor3", -- Circle of People
		images = {"14cd2b5243c.png","14cd2a6f3dc.png"},
		room = translate("art"),
		x = {2623, 2621},
		y = {349, 437},
		size = {135,135}
	},
}

box = {}
for i, item in ipairs(items) do
	item.name = translate(item.name_id)
	box[i] = i
end
table.shuffle(box)

npc={
	right="VlNK06Z",
	left="1529dffe4d0",
	x=3410,
	y=850,
	xoff=-25,
	yoff=-64
}

decorationsDone = 0
celebration = false
ticks = 1
poemLine = 1
blnticks = 0
poem = {
	"Sanki her tarafta var bir düğün.", -- DO NOT TOUCH THIS
	"Çünkü, en şerefli en mutlu gün.",
	"Bugün 23 Nisan,",
	"Hep neşeyle doluyor insan.",
	"İşte, bugün bir meclis kuruldu,",
	"Sonra hemen padişah kovuldu.",
	"Bugün 23 Nisan,",
	"Hep neşeyle doluyor insan.",
	"Bugün, Atatürk'ten bir armağan,",
	"Yoksa, tutsak olurduk sen inan.",
	"Bugün 23 Nisan,",
	"Hep neşeyle doluyor insan."
},

-- PRE-DECLARATIONS --
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoNewGame(true)


-- HANDLE GIVING ITEMS --
function giveItems(name)
	local player = players[name]
	if not player.item then
		if #box > 0 then -- take one off the stack
			player.item = table.remove(box)
		else
			local firstItem = nil
			local earliest = os.time()
			for i, item in ipairs(items) do
				if item.taken and item.taken < earliest and not item.placed then -- item was taken earlier
					earliest = item.taken
					firstItem = i
				end
			end
			player.item = firstItem
		end
		local item = items[player.item]
		item.taken = os.time()
		tfm.exec.chatMessage(string.format(translate("itemTaken2"), item.name, item.room), name)
		player.img = tfm.exec.addImage(item.images[2], "&3", 745, 335, name)
		ui.addTextArea(2,string.format(translate("itemTaken"), item.name, item.room),name,npc.x-100,npc.y-100,200,nil,0x324650,0x212F36,0.8)
		local item = items[player.item]
		if player.path then
			erasePath(player.path)
		end
		player.path = drawPath(3050,859,item.x[2],item.y[2], name)
	else
		tfm.exec.chatMessage(string.format(translate("alreadyHave"), items[player.item].name, items[player.item].room), name)
	end
end

-- DRAW TRAILS --
function drawPath(x1, y1, x2, y2, name)
	local res = {}
	local dx, dy = x2 - x1, y2 - y1
	local l = math.sqrt(dx^2 + dy^2)
	local dashes = math.floor(l/100)
	local xstep, ystep = dx/dashes, dy/dashes
	local x, y = x1 - 0.5*xstep - 16, y1 - 0.5*ystep - 16
	for i = 0, dashes - 1 do
	x, y = x + xstep, y + ystep
		table.insert(res,tfm.exec.addImage("1529dfc7fef.png","?50",x + math.random()*0.5*xstep,y + math.random()*0.5*ystep,name))
	end
	return res
end

function erasePath(path)
	for i, image in ipairs(path) do
		tfm.exec.removeImage(image)
	end
end

--[[function stringtotable(str, tblopen, tblclose, separate, whatdoicallthis)
	tblopen = tblopen or "{"
	tblclose = tblclose or "}"
	separate = separate or "$"
	whatdoicallthis = whatdoicallthis or "="
	str = str:sub(2,str:len()-1)

	local indexed = string.split(str,separate)
	local ans = {}
	local counter = 0
	local concat = ""
	local tablekey = ""

	if #indexed == 1 then
		local t = string.split(str, whatdoicallthis)
		if #t == 2 then
			ans[t[1] = t[2]
		else
			ans[#ans+1] = v
		end
		return ans
	end

	for k,v in pairs(indexed) do
		if counter == 0 then
			if v:find(tblopen) then
				local t = string.split(v,tblopen)
				if t[1]:find(whatdoicallthis) then
					concat = ""
					for i=2,#t do
						concat = concat..tblopen..t
					end
					tablekey = t[1]:sub(1,t[1]:len()-whatdoicallthis:len())
				else
					tablekey = #ans+1
					concat = v
				end
				if v:find(tblclose) then
					ans[tablekey] = stringtotable(concat, tblopen, tblclose, separate, whatdoicallthis)
				else
					counter = 1
				end
			else
				local t = string.split(v, whatdoicallthis)
				if #t == 2 then
					ans[t[1] = t[2]
				else
					ans[#ans+1] = v
				end
				print(v)
			end
		else
			for i=1, v:len() do
				local s = v:sub(i,i)
				if s:find(tblopen) then
				counter = counter + 1
				end
				if s:find(tblclose) then
					counter = counter - 1
				end
			end
			concat = concat..separate..v
			if counter == 0 then
				ans[tablekey] = stringtotable(concat, tblopen, tblclose, separate, whatdoicallthis)
				ans[tablekey] = stringtotable(concat, tblopen, tblclose, separate, whatdoicallthis)
			end
		end
	end
	return ans
end

function tabletostring(tbl, tblopen, tblclose, separate, whatdoicallthis)
	tblopen = tblopen or "{"
	tblclose = tblclose or "}"
	separate = separate or "$"
	whatdoicallthis = whatdoicallthis or "="
	local str = tblopen
	for k,v in pairs(tbl) do
		if type(v) == 'table' then
			str = str..tostring(k)..whatdoicallthis..tabletostring(v,tblopen,tblclose,separate,whatdoicallthis)..separate
		else
			str = str..tostring(k)..whatdoicallthis..tostring(v)..separate
		end
	end
	str = str:sub(1,str:len()-separate:len())
	return str..tblclose
end]]


-- MAP UI UPDATE & REMAINING DECORATIONS
function remainingDecoration(num)
	tfm.exec.setUIMapName(string.format("Children's Day   <G>|   <N>%s : <V>%d / 22", translate("decorations"), num or decorationsDone))
end

-- CELEBRATION --
function startCelebration()
	--tfm.exec.addShamanObject(10,2000,680)
	--ui.addTextArea(6,"<p align='center'>Expect me.</p>",nil,1950,640,100,40,0x324650,0x212F36,0)
	renderBackground()
	celebration = true
	tfm.exec.chatMessage(translate("endEvent"))
	for name,player in pairs(tfm.get.room.playerList) do
		tfm.exec.setGameTime(20, false)
		if not player.isDead then
			collected(name)
			tfm.exec.movePlayer(name, math.random(1380, 1680), 835)
			tfm.exec.removeImage(players[name].teacher)
			tfm.exec.addImage(npc.left..".png","!1",1526+npc.xoff,788,name)
			ui.addTextArea(2,"23 Nisan",name,1426,775,200,nil,0x324650,0x212F36,0.8)
		end
	end
	--[[if saveFile then
		saveStats(tfm.get.room.community)
	end]]
end

-- EVENT KEYBOARD --
function eventKeyboard(name, key, down, x, y)
	if not celebration then
		if inner_circle(3050,859,35,tfm.get.room.playerList[name].x,tfm.get.room.playerList[name].y,35) and key == 32 then
			giveItems(name)
		elseif players[name].item and inner_circle(items[players[name].item].x[2], items[players[name].item].y[2], 50,tfm.get.room.playerList[name].x,tfm.get.room.playerList[name].y,50) and key == 32 then
			local item = players[name].item
			items[item].placed = true
			tfm.exec.addImage(items[item].images[1],"?51",items[item].x[1]-(items[item].size[1]/2),items[item].y[1]-(items[item].size[2]/2),nil)
			tfm.exec.removeImage(players[name].img)
			collected(name)
			players[name].item = nil
			players[name].img = nil
			tfm.exec.chatMessage(translate("wellDone"), name)
			ui.addTextArea(2,translate("teacherIntro"),name,npc.x-150,npc.y-100,325,nil,0x324650,0x212F36,0.8)
			decorationsDone = decorationsDone + 1
			remainingDecoration()
			if decorationsDone == 22 then
				startCelebration()
			end
		end
	end
end

-- EVENT PLAYER DEATH --
function eventPlayerDied(name)
	if players[name] then
		if players[name].item then
			table.insert(box, players[name].item)
		end
	end
end

-- EVENT PLAYER LEFT --
function eventPlayerLeft(player)
	if players[player] then
		if players[player].item then
			table.insert(box, players[player].item)
			players[player] = nil
		end
	end
end

-- EVENT NEW PLAYER --
function eventNewPlayer(name)
	players[name]={
		images={},
		completed=0
	}
	if playerData then system.loadPlayerData(name) end
	renderBackground(name)
	players[name].teacher = tfm.exec.addImage(npc.left..".png","!1",npc.x+npc.xoff,npc.y+npc.yoff,name)
	tfm.exec.bindKeyboard(name,32,true,true)
	tfm.exec.addImage("erLxfXj.png", "&2", 735, 325, name)
	ui.addTextArea(2,translate("teacherIntro"),name,npc.x-150,npc.y-100,325,nil,0x324650,0x212F36,0.8)
	showEventItems(name,players[name].completed)
end

function collected(name)
	players[name].completed=players[name].completed+1
	if playerData then system.savePlayerData(name,"event"..players[name].completed) end
	showEventItems(name,players[name].completed)
	if players[name].completed >= 20 then
		system.giveEventGift(name, "titre_enfant_2014")
	end
	if players[name].completed >= 50 then
		system.giveEventGift(name, "titre_enfant_2015")
	end
	--[[if saveFile then playerGetsShit(name) end]]
end

function showEventItems(name,a)
	local a,s,f,x,y,w,h,tA,b="<p align='left'>"..a,1,true,758,382,50,20,ui.addTextArea
	b="<font color='#1'>"..a
	tA(-201,b,name,x+s,y,w,h,0,1,0,f)
	tA(-202,b,name,x-s,y,w,h,0,1,0,f)
	tA(-203,b,name,x,y+s,w,h,0,1,0,f)
	tA(-204,b,name,x,y-s,w,h,0,1,0,f)
	tA(-205,b,name,x+s,y-s,w,h,0,1,0,f)
	tA(-206,b,name,x-s,y-s,w,h,0,1,0,f)
	tA(-207,b,name,x+s,y+s,w,h,0,1,0,f)
	tA(-208,b,name,x-s,y+s,w,h,0,1,0,f)
	tA(-209,a,name,x,y,w,h,0,0,0,f)
end

function renderBackground(name)
	tfm.exec.addImage("14cce6ffd55.jpg","?50",0,-20,name)
	tfm.exec.addImage("14cce705f5b.png","!50",0,-20,name)
	for i, item in ipairs(items) do
		if item.placed then
			tfm.exec.addImage(item.images[1],"?51",item.x[1]-(item.size[1]/2),item.y[1]-(item.size[2]/2),name)
		end
	end
end

--[[function eventNewGame()
	if saveFile then system.loadFile(99) end
end]]

--[[function eventFileLoaded(id, file)
	if #file>1 then stats=stringtotable(file) end
end]]

-- When the player collects something.
--[[function playerGetsShit(name)
    local playerInList=false
	if not stats[tfm.get.room.community] then stats[tfm.get.room.community]={celebrations=0,topplayers={}} end
    for k,v in ipairs(stats[tfm.get.room.community].topplayers) do
        if v.name==name then
        	stats[tfm.get.room.community].topplayers[k].score=players[name].completed
			playerInList=true
        end
    end
    if not playerInList then
        table.insert(stats[tfm.get.room.community].topplayers,{name=name,score=players[name].completed})
    end
end]]

--[[function eventChatCommand(name, command)
	if (name == "Ediz" or name=="Shamousey") then
		if command == "cel" then
			startCelebration()
		elseif command == "print" then
			printInfo("stats",stats)
		end
	end
end]]

function eventLoop(t, r)
	if celebration then
		ticks = ticks + 1
		if ticks == 3 then
			ticks = 1
			poemLine = poemLine + 1
			ui.updateTextArea(2, '<p align="center"><vp>'..poem[poemLine]..'</p>', nil)
			if poemLine >= 12 then
				poemLine = 0
			end
		end
		blnticks = blnticks + 1
		if blnticks % 4 == 0 then
			tfm.exec.addShamanObject(28, math.random(1342, 1508), 835)
			tfm.exec.addShamanObject(28, math.random(1528, 1696), 835)
		end
	end
	if r<=0 then system.exit() end
end

function eventPlayerDataLoaded(name,data)
	if data:sub(1,5)=="event" then
		players[name].completed=tonumber(data:sub(6)) or 0
		showEventItems(name,players[name].completed)
	end
end

tfm.exec.newGame(xml)
tfm.exec.setGameTime(150)
for name,player in pairs(tfm.get.room.playerList) do
	eventNewPlayer(name)
end
remainingDecoration()
tfm.exec.addImage("1529dfd4be7.png", "&1", 735, 380)

-- [[  for _,name in ipairs({"Shamousey","Ediz"}) do system.savePlayerData(name,"") end]]
