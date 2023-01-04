file = open('Joestar-tree-2.ged', 'r', encoding='UTF-8')
file_2 = open('Joestar-tree-2.pl', 'w', encoding='UTF-8')

predicates = list()
id_dict = dict()

pred = ''
pred_2 = ''
p_id = ''

for line in file.readlines():
    if '0 @I' in line:
        pred = '('
        p_id = line[2:-6]
    elif '1 NAME' in line and pred == '(':
        pred += '\''
        pred += line[7:-1].replace('/', '').strip()
        pred += '\''
        pred += ')'
        id_dict[p_id] = pred[1:-1]
    elif '1 SEX' in line and len(pred) > 0 and pred[0] == '(':
        if '1 SEX M' in line:
            pred = 'male' + pred
        elif '1 SEX F' in line:
            pred = 'female' + pred
        predicates.append(pred)
        pred = ''
        p_id = ''
    elif '0 @F' in line:
        pred = ', '
        pred_2 = ', '
    elif '1 HUSB' in line and pred == ', ':
        pred += id_dict[line[7:-1]]
        pred += ')'
    elif '1 WIFE' in line and pred_2 == ', ':
        pred_2 += id_dict[line[7:-1]]
        pred_2 += ')'
    elif '1 CHIL' in line:
        child_name = id_dict[line[7:-1]]
        if len(pred) > 0 and pred != ', ':
            predicates.append('child(' + child_name + pred)
        if len(pred_2) > 0 and pred_2 != ', ':
            predicates.append('child(' + child_name + pred_2)

# print('\n'.join(predicates))

for line in predicates:
    file_2.write(line + '.\n')

file.close()
file_2.close()
