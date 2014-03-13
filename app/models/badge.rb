# coding: utf-8

class Badge < ActiveRecord::Base

	attr_accessible :description, :name, :official_name, :metal
	has_and_belongs_to_many :users

	validates :name, :presence => true, :uniqueness => true
	validates :official_name, :presence => true

	@metal_values = {:bronze => "bronze", :silver => "silver", :gold => "gold"}


	def self.initialize (name, official_name, description, metal)
		Badge.create(:name => name, :official_name => official_name, :description => description, :metal => @metal_values[metal])
	end


	# Ces lignes permettent d'initialiser tous les badges. 
	def self.init_db()

		Badge.initialize("one_question", "Interrogatif", "Avoir posé une question.", :bronze)
		Badge.initialize("ten_questions", "Curieux", "Avoir posé dix questions.", :silver)
		Badge.initialize("hundred_questions","Machine à questions", "Avoir posé cent questions.", :gold)

		Badge.initialize("remarquable_question", "Question remarquable", "Avoir posé une question vue cent fois.", :bronze)
		Badge.initialize("popular_question", "Question populaire", "Avoir posé une question vue 250 fois.", :silver)
		Badge.initialize("must_question","Question incontournable", "Avoir posé une question vue 1000 fois.", :gold)

		Badge.initialize("tiny_question", "Petite question", "Avoir posé une question ayant dépassé un score de 10.", :bronze)
		Badge.initialize("good_question", "Bonne question", "Avoir posé une question ayant dépassé un score de 25.", :silver)
		Badge.initialize("very_good_question", "Très bonne question", "Avoir posé une question ayant dépassé un score de 100.", :gold)

		Badge.initialize("tiny_answer", "Petite réponse", "Avoir posé une réponse ayant dépassé un score de 10.", :bronze)
		Badge.initialize("good_answer", "Bonne réponse", "Avoir posé une réponse ayant dépassé un score de 25.", :silver)
		Badge.initialize("very_good_answer", "Très bonne réponse", "Avoir posé une réponse ayant dépassé un score de 100.", :gold)

		Badge.initialize("rather_popular", "Modérément réputé", "Avoir dépassé une réputation de 10.", :bronze)
		Badge.initialize("popular", "Réputé", "Avoir dépassé une réputation de 25.", :silver)
		Badge.initialize("very_popular", "Très Réputé", "Avoir dépassé une réputation de 100.", :gold)


	end

	def self.load_badges()
		@one_question ||= Badge.find_by_name("one_question")
		@ten_questions ||= Badge.find_by_name("ten_questions")
		@hundred_questions ||= Badge.find_by_name("hundred_questions")
		@metal_question_count = {:bronze => 1, :silver => 10, :gold => 100}
		@badge_question_count = {:bronze =>@one_question, :silver => @ten_questions, :gold =>@hundred_questions }


		@remarquable_question ||= Badge.find_by_name("remarquable_question")
		@popular_question ||= Badge.find_by_name("popular_question")
		@must_question ||= Badge.find_by_name("must_question")
		@metal_question_views = {:bronze => 100, :silver => 250, :gold => 1000}
		@badge_question_views = {:bronze =>@remarquable_question, :silver => @popular_question, :gold =>@must_question }


		@tiny_question ||= Badge.find_by_name("tiny_question")
		@good_question ||= Badge.find_by_name("good_question")
		@very_good_question ||= Badge.find_by_name("very_good_question")
		@metal_question_score = {:bronze => 10, :silver => 25, :gold => 100}
		@badge_question_score = {:bronze =>@tiny_question, :silver => @good_question, :gold =>@very_good_question }


		@tiny_answer ||= Badge.find_by_name("tiny_answer")
		@good_answer ||= Badge.find_by_name("good_answer")
		@very_good_answer ||= Badge.find_by_name("very_good_answer")
		@metal_answer_score = {:bronze => 10, :silver => 25, :gold => 100}
		@badge_answer_score = {:bronze =>@tiny_answer, :silver => @good_answer, :gold =>@very_good_answer }


		@rather_popular ||= Badge.find_by_name("rather_popular")
		@popular ||= Badge.find_by_name("popular")
		@very_popular ||= Badge.find_by_name("very_popular")
		@metal_user_score = {:bronze => 10, :silver => 25, :gold => 100}
		@badge_user_score = {:bronze =>@rather_popular, :silver => @popular, :gold =>@very_popular }



		class << self
			def load_badges()
			end
		end
	end



	def self.update_on_question(question)
		load_badges
		user = question.user
		user.give_badge(self.match_score_to_badge(@metal_question_count, user.questions.count, @badge_question_count))
	end

	def self.update_on_question_view(question)
		load_badges
		user = question.user
		user.give_badge(self.match_score_to_badge(@metal_question_views, question.views, @badge_question_views))
	end

	def self.update_on_question_vote_up(question)
		load_badges
		user = question.user
		user.give_badge(self.match_score_to_badge(@metal_question_score, question.score, @badge_question_score))
		user.give_badge(self.match_score_to_badge(@metal_user_score, user.karma , @badge_user_score))
	end

	def self.update_on_answer_vote_up(answer)
		load_badges
		user = answer.user
		user.give_badge(self.match_score_to_badge(@metal_answer_score, answer.score, @badge_answer_score))
		user.give_badge(self.match_score_to_badge(@metal_user_score, user.karma , @badge_user_score))
	end

	def self.match_score_to_badge(threshold_scores, score, badges)
		if (score>= threshold_scores[:silver])
			if (score>= threshold_scores[:gold])
				badges[:gold]
			else
				puts(badges[:silver])
				badges[:silver]
			end
		elsif (score>=threshold_scores[:bronze])
			badges[:bronze]
		else
			nil
		end
	end


	def self.one_question
		Badge.find_by_name("one_question")
	end

	def self.hundred_questions
		Badge.find_by_name("hundred_questions")
	end



	def self.destroy_everything
		Badge.all.each do |u|
			u.destroy
		end
	end
end
