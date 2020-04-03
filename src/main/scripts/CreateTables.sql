    create table artifacts (
       id bigint not null,
        endpoint varchar(255) not null,
        name varchar(255) not null,
        type varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table assessment_ratings (
       assessment_id bigint not null,
        rating_id bigint not null
    ) engine=InnoDB;

    create table assessments (
       id bigint not null,
        comments varchar(255),
        completed bit not null,
        date datetime(6),
        deleted bit not null,
        assesor_id bigint,
        artifact_id bigint,
        rubric_id bigint,
        task_id bigint,
        primary key (id)
    ) engine=InnoDB;

    create table criteria (
       id bigint not null,
        deleted bit not null,
        description varchar(255) not null,
        name varchar(255) not null,
        publish_date datetime(6),
        reusable bit not null,
        FULLTEXT(name,description),
        primary key (id)
    ) engine=InnoDB;

    create table criterion_tags (
       criterion_id bigint not null,
        tag_id bigint not null
    ) engine=InnoDB;

    create table hibernate_sequence (
       next_val bigint
    ) engine=InnoDB;

    insert into hibernate_sequence values ( 1 );

    insert into hibernate_sequence values ( 1 );

    insert into hibernate_sequence values ( 1 );

    insert into hibernate_sequence values ( 1 );

    insert into hibernate_sequence values ( 1 );

    insert into hibernate_sequence values ( 1 );

    insert into hibernate_sequence values ( 1 );

    insert into hibernate_sequence values ( 1 );

    create table ratings (
       id bigint not null,
        description varchar(255) not null,
        value double precision not null,
        criterion_id bigint,
        FULLTEXT(description),
        primary key (id)
    ) engine=InnoDB;

    create table rubric_criteria (
       rubric_id bigint not null,
        criterion_id bigint not null,
        criterion_order integer not null,
        primary key (rubric_id, criterion_order)
    ) engine=InnoDB;

    create table rubrics (
       id bigint not null,
        deleted bit not null,
        description varchar(255),
        public bit not null,
        last_updated_date timestamp not null default current_timestamp,
        name varchar(255) not null,
        obsolete bit not null,
        publish_date datetime(6),
        creator_id bigint,
        FULLTEXT(name,description),
        primary key (id)
    ) engine=InnoDB;

    create table tags (
       id bigint not null,
        count integer not null,
        value varchar(255) not null,
        FULLTEXT(value),
        primary key (id)
    ) engine=InnoDB;

    create table tasks (
       id bigint not null,
        due_date datetime(6),
        name varchar(255) not null,
        type varchar(255) not null,
        evaluator_id bigint,
        rubric_id bigint,
        primary key (id)
    ) engine=InnoDB;

    create table users (
       id bigint not null,
        cin varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        middle_name varchar(255),
        password varchar(255) not null,
        username varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK_ka6m8ghsr7vna1ti6lftwww8o unique (cin);

    alter table users 
       add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username);

    alter table assessment_ratings 
       add constraint FKpf7rbs9siysidpavy0kvci08m 
       foreign key (rating_id) 
       references ratings (id);

    alter table assessment_ratings 
       add constraint FK85whnro40v36j4ai3c8pby0gf 
       foreign key (assessment_id) 
       references assessments (id);

	alter table assessments 
       add constraint FKc66egnd7uamp4oyucik0upfl7 
       foreign key (artifact_id) 
       references artifacts (id);

    alter table assessments 
       add constraint FKs7rtlo6e56y6kl5hervu5fehm 
       foreign key (assesor_id) 
       references users (id);
	

    alter table assessments 
       add constraint FK7va5fxsqvo6tth0jwvpynrpah 
       foreign key (rubric_id) 
       references rubrics (id);

    alter table assessments 
       add constraint FKqwksq4urufoxd7unq3j5t8a4r 
       foreign key (task_id) 
       references tasks (id);

    alter table criterion_tags 
       add constraint FKi7hmj6w4cwfju9raklytid47o 
       foreign key (tag_id) 
       references tags (id);

    alter table criterion_tags 
       add constraint FK60113r10ymtj1i21yop0mijdl 
       foreign key (criterion_id) 
       references criteria (id);

    alter table ratings 
       add constraint FKqkq5f3y63dkujpg7imq036s2n 
       foreign key (criterion_id) 
       references criteria (id);

    alter table rubric_criteria 
       add constraint FKiqehfsbkmxgry7gjiq7j5c7xh 
       foreign key (criterion_id) 
       references criteria (id);

    alter table rubric_criteria 
       add constraint FKjs1mcsyrjsecv9qu0em2ldafw 
       foreign key (rubric_id) 
       references rubrics (id);

    alter table rubrics 
       add constraint FK2w3xneoptjuj9tdmjbmt09rr6 
       foreign key (creator_id) 
       references users (id);

    alter table tasks 
       add constraint FK5a855yh5kwk4d0h9p6k5uphvx 
       foreign key (evaluator_id) 
       references users (id);

    alter table tasks 
       add constraint FKcnegrugc9fvfwtdrmeb65agp3 
       foreign key (rubric_id) 
       references rubrics (id);
