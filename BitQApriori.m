function L=BitQApriori(T,MST)

    % Create Items Set
    Items=[];
    for i=1:numel(T)
        Items=union(Items,T{i});
    end
    Items=Items(:)';
    
    % 1st level Candidates
    C{1}=cell(1,numel(Items));
    count{1}=zeros(size(C{1}));
    for r=1:numel(Items)
        C{1}{r}=Items(r);
        for i=1:numel(T)
            if IsContainedIn(C{1}{r},T{i})
                count{1}(r)=count{1}(r)+1;
            end
        end
    end
    % 1st Level Frequent Patterns
    L{1}=C{1}(count{1}/numel(T)>=MST);

    % Initialize Counter
    k=1;

    % Iterations
    while ~isempty(L{k})

        b=[];
        for i=1:numel(L{k})
            b=union(b,L{k}{i});
        end
        b=b(:)';
        
        % (k+1)-th Level Candidates
        C{k+1}={}; %#ok
        for i=1:numel(L{k})
            A=L{k}{i};
            for j=1:numel(b);
                if ~ismember(b(j),A)
                    New=[A b(j)];
                    Found=false;
                    for r=1:numel(C{k+1})
                        if IsSame(New,C{k+1}{r})
                            Found=true;
                            break;
                        end
                    end
                    if ~Found
                        C{k+1}=[C{k+1} {New}];
                    end
                end
            end
        end
        
        % Calculate Patterns Counts
        count{k+1}=zeros(size(C{2})); %#ok
        for r=1:numel(C{k+1})
            for i=1:numel(T)
                if IsContainedIn(C{k+1}{r},T{i})
                    count{k+1}(r)=count{k+1}(r)+1;
                end
            end
        end
        
        % (k+1)-th Level Frequent Patterns
        L{k+1}=C{k+1}(count{k+1}/numel(T)>=MST); %#ok
        
        % Increment Counter
        k=k+1;

    end

    L=L(1:end-1);

   