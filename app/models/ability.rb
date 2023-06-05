# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  #for guest users
    if user.present? 
      can [:read, :search], Course, state: :published 
      can [:read, :update], Profile, profileable_id: user.id
      can :create, Profile if user.profile.nil?
      if user.has_role? :student
        can :create, Admission
        can [:read, :update], Admission, user_id: user.id
      end
      if user.has_role? :administrator
        can :manage, SubjectSchedule
        can :manage, User
        can :manage, Subject
        can :manage, Student
        can :manage, Profile
        cannot :create, Profile if user.profile.present?
        can :manage, Course
      end
    end
  end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
end
