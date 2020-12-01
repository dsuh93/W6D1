class Response < ApplicationRecord
    validate :not_duplicate_response

    def sibling_responses   
        self.question.responses.where.not(self.id)
    end

    def respondent_already_answered?
        sibling_responses.exists?(self.respondent_id)
    end

    def not_duplicate_response
        if respondent_already_answered? == true
            errors[:base] << "Respondent as already answered this question"
        end
    end

    

    belongs_to :answer_choice,
        foreign_key: :answer_choice_id,
        primary_key: :id,
        class_name: :AnswerChoice 

    belongs_to :respondent,
        foreign_key: :respondent_id,
        primary_key: :id,
        class_name: :User

    has_one :question,
        through: :answer_choice,
        source: :question 
end