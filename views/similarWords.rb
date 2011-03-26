require 'rubygems'
require 'wordnik-ruby'
require 'whois'

#Method that returns a set of similar words
def similarWords(wordVar)
	similarWordsHash = Hash.new()
	similarWordsSet = Set.new()
	puts "****************#{wordVar}******************"
	#Find the word in wordnik
	word2Find = Wordnik::Word.find(wordVar)
	relatedWord = word2Find.related
	relatedWord.each do|relation,word|
#		puts "*****#{relation} #{word.size}******"
		wordsArray = Array.new()
		word.each do |similarWord|
#			puts "#{similarWord.wordstring}"
#			wordsArray.push(similarWord.wordstring.gsub(/[  ',]/,""))
			#Remove spaces ' and . before adding	
			similarWordsSet.add(similarWord.wordstring.gsub(/\s+|'|-|\./,""))
		end
#		similarWordsHash[relation] = wordsArray
	end
	similarWordsSet.add(wordVar)
	similarWordsSet = similarWordsSet.sort_by{|i| i.length}
	similarWordsSet.each do |word|
		puts "#{word}"
	end
	return similarWordsSet
end

#Method that takes a sets of words and returns an array that has them merged
def mergeSetWords(*params)
	mergedArray = Array.new()
		params.each do |wordset|
			wordset.each do |eachword|
				if(eachword.length<20)
#					a = Whois.whois(eachword+".com")
#					if(a.available? )
						puts "#{eachword} available"
						mergedArray.push(eachword+".com")
#					end	
				end
			end
		end
		mergedArray.each do |domains|
			puts "#{domains}"
		end
			
	return mergedArray.sort_by{|i| i.length}
end

def findSimilar(inputString)
	wordnik=Wordnik::Wordnik.new({:api_key=>'06a5606383d6c88d1840a0daf0108071054396e3a4114f334', :username=>'eposts', :password=>'hithere'})
	if(wordnik.authenticated?)
		print "wordnik authentication worked"	
		stringArray = inputString.split(' ')
	
		if(stringArray[0])
			similarWordSet1 = similarWords(stringArray[0])
		end
		if(stringArray[1])
			similarWordSet2 = similarWords(stringArray[1])
		end
		if(stringArray[2])
			similarWordSet3 = similarWords(stringArray[2])
		end
		case stringArray.size
			when 2
				mergeSetWords(similarWordSet1, similarWordSet2)	
			when 3
				mergeSetWords(similarWordSet1, similarWordSet2, similarWordSet3)
		end	

	else
		print "wordnik authentication failed"
	end
end
