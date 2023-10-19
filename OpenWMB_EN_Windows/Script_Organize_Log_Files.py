##Imports libraries
import pandas as pd
import os

#Stores the path where the the data files from the participants are located.
part_data_path = os.getcwd() + "\data_participants"

#Creates a list with the names of all files located in the variable part_data_path.
#Creates a list with the name of all data files.
list_of_files = os.listdir(part_data_path)

#Adds the root 'data_participants' to the list that contains the name of all data files.
full_path_files = []
for i in range(0,len(list_of_files)):
    create_str_file = 'data_participants/' + list_of_files[i]
    full_path_files.append(create_str_file)

#Creates a dataframe with the data of all participants. It uses the method 'read_csv' to create a DataFrame for the data of each
#participant and the mehtod a append and uses the method append() to bind all these dataframes.
df_total_part = pd.DataFrame()
for i in range(0, len(full_path_files)):
    df = pd.read_csv(full_path_files[i],error_bad_lines=False)
    df_total_part = df_total_part.append(df)

#Corrects missing values (e. g., replaces 'undefined' by 'Nan').
df_total_part = df_total_part.replace('undefined','Nan')


#Places the ID of the particioant and the name of the task to the first and second column.
first_column = df_total_part.pop('Task_Name')
second_column = df_total_part.pop('subject_nr')
df_total_part.insert(0, 'Task_Name', first_column)
df_total_part.insert(1, 'subject_nr', second_column)

#The next 7 blocks of code create 7 Dataframes.
#Each Dataframe will contain all information regarding one of the six WM tasks (symmetry span, n-back task, multimodal span,
# operation span, binding task e Updating Task).

df_N_Back = df_total_part[df_total_part['Task_Name'] == 'N-Back Task']
#print(df_N_Back)

df_WMU_Task = df_total_part[df_total_part['Task_Name'] == 'Working Memory Updating Task']
#print(df_WMU_Task)

df_Binding_Task = df_total_part[df_total_part['Task_Name'] == 'Binding Task']
#print(df_Binding_Task)

df_Operation_Span = df_total_part[df_total_part['Task_Name'] == 'Operation Span']
#print(df_Operation_Span)

df_Multimodal_Span = df_total_part[df_total_part['Task_Name'] == 'Multimodal Span']
#print(df_Multimodal_Span)

df_Symmetry_Span = df_total_part[df_total_part['Task_Name'] == 'Symmetry Span']
#print(df_Symmetry_Span)

#The next 7 blocks of code select the column with important information regarding each WM task and store these columns in 7 dataframes.
#Some data conversion procedures are employed in the next blocks (e.g., string to float). Additionally, the names of the colums are
#converted to a friendlier format.
if "Yes" in df_total_part['selNB'].values:
    if df_N_Back.iloc[0]['selSocDem'] == "Yes":
        df_N_Back= df_N_Back[['subject_nr','age','gender','nationality','AttendUniv','HabStudent','HabNonStudent','PreviousDiseases','PreviousDiseasesList','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'average_response_time', 'Block_lenght', 'correct', 'CounterN2BackTrials', 'CounterNonN2BackTrials', 'height', 'letter', 'letter_pos', 'List_Last_N_Pos', 'List_Last_N_Verbal', 'live_row', 'logfile', 'NBackScore', 'RefCalcN2Back', 'RefCalcNonN2Back', 'response', 'response_index_letter', 'response_index_pos', 'response_time', 'rt_correct_n_back','rt_false_alarms', 'SelectCondition', 'TotalCorrectNonTwoBack', 'TotalCorrectTwoBack', 'TotalFalseAlarms', 'TotalMiss', 'width']]
        for i in range(0,len(df_N_Back['average_response_time'])):
            if df_N_Back['average_response_time'].iloc[i] != 'undefined':
                floated_average_response_time = float(df_N_Back['average_response_time'].iloc[i])
                df_N_Back = df_N_Back.replace(df_N_Back['average_response_time'].iloc[i],floated_average_response_time)
        df_N_Back = df_N_Back.sort_values(by=['subject_nr'], kind='mergesort')
    else:
        df_N_Back= df_N_Back[['subject_nr','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'average_response_time', 'Block_lenght', 'correct', 'CounterN2BackTrials', 'CounterNonN2BackTrials', 'height', 'letter', 'letter_pos', 'List_Last_N_Pos', 'List_Last_N_Verbal', 'live_row', 'logfile', 'NBackScore', 'RefCalcN2Back', 'RefCalcNonN2Back', 'response', 'response_index_letter', 'response_index_pos', 'response_time', 'rt_correct_n_back','rt_false_alarms', 'SelectCondition', 'TotalCorrectNonTwoBack', 'TotalCorrectTwoBack', 'TotalFalseAlarms', 'TotalMiss', 'width']]
        for i in range(0,len(df_N_Back['average_response_time'])):
            if df_N_Back['average_response_time'].iloc[i] != 'undefined':
                floated_average_response_time = float(df_N_Back['average_response_time'].iloc[i])
                df_N_Back = df_N_Back.replace(df_N_Back['average_response_time'].iloc[i],floated_average_response_time)
        df_N_Back = df_N_Back.sort_values(by=['subject_nr'], kind='mergesort')

#'Equations',
if "Yes" in df_total_part['selOS'].values:
    if df_Operation_Span.iloc[0]['selSocDem'] == "Yes":
        df_Operation_Span = df_Operation_Span[['subject_nr','age','gender','nationality','AttendUniv','HabStudent','HabNonStudent','PreviousDiseases','PreviousDiseasesList','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'subblock', 'SubTaskName', 'acc', 'avg_rt', 'BlockChoice', 'correct', 'correct_response', 'height', 'letter', 'List_Prev_Letter', 'List_responses_memory', 'live_row', 'logfile', 'response_average_time_memory', 'response_memory', 'response_processing', 'response_time_memory', 'response_time_processing', 'response_total_time_memory', 'OP_part_process_time', 'score_practice', 'score_operation_span', 'score_subblock_2_1', 'score_subblock_2_2', 'score_subblock_2_3', 'score_subblock_3_1', 'score_subblock_3_2', 'score_subblock_3_3', 'score_subblock_4_1', 'score_subblock_4_2', 'score_subblock_4_3', 'score_subblock_5_1', 'score_subblock_5_2', 'score_subblock_5_3', 'score_subblock_6_1', 'score_subblock_6_2', 'score_subblock_6_3', 'Sub_bloco', 'Tipo', 'total_correct', 'total_response_time', 'total_responses', 'width']]
        df_Operation_Span[['acc','avg_rt']] = df_Operation_Span[['acc','avg_rt']].replace(',','.')
        df_Operation_Span = df_Operation_Span.astype({'acc': 'float64','avg_rt': 'float64', 'correct_response': 'str','response_processing':'str','subblock':'str'})
        example_c = df_Operation_Span["response_processing"].iloc[2]
        df_Operation_Span = df_Operation_Span.replace(example_c,'')
        df_Operation_Span = df_Operation_Span.sort_values(by=['subject_nr'], kind='mergesort')
    else:
        df_Operation_Span = df_Operation_Span[['subject_nr','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'subblock', 'SubTaskName', 'acc', 'avg_rt', 'BlockChoice', 'correct', 'correct_response', 'height', 'letter', 'List_Prev_Letter', 'List_responses_memory', 'live_row', 'logfile', 'response_average_time_memory', 'response_memory', 'response_processing', 'response_time_memory', 'response_time_processing', 'response_total_time_memory', 'OP_part_process_time', 'score_practice', 'score_operation_span', 'score_subblock_2_1', 'score_subblock_2_2', 'score_subblock_2_3', 'score_subblock_3_1', 'score_subblock_3_2', 'score_subblock_3_3', 'score_subblock_4_1', 'score_subblock_4_2', 'score_subblock_4_3', 'score_subblock_5_1', 'score_subblock_5_2', 'score_subblock_5_3', 'score_subblock_6_1', 'score_subblock_6_2', 'score_subblock_6_3', 'Sub_bloco', 'Tipo', 'total_correct', 'total_response_time', 'total_responses', 'width']]
        df_Operation_Span[['acc','avg_rt']] = df_Operation_Span[['acc','avg_rt']].replace(',','.')
        df_Operation_Span = df_Operation_Span.astype({'acc': 'float64','avg_rt': 'float64', 'correct_response': 'str','response_processing':'str','subblock':'str'})
        example_c = df_Operation_Span["response_processing"].iloc[2]
        df_Operation_Span = df_Operation_Span.replace(example_c,'')
        df_Operation_Span = df_Operation_Span.sort_values(by=['subject_nr'], kind='mergesort')

if "Yes" in df_total_part['selBT'].values:
    if df_Binding_Task.iloc[0]['selSocDem'] == "Yes":
        df_Binding_Task = df_Binding_Task[['subject_nr','age','gender','nationality','AttendUniv','HabStudent','HabNonStudent','PreviousDiseases','PreviousDiseasesList','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'acc', 'average_response_time', 'BindingRawScore', 'correct', 'correct_response', 'counter', 'Delay', 'eightsec_accuracy', 'FalseAlarms', 'height', 'Hits', 'live_row', 'logfile', 'match_1s_accuracy', 'match_1s_avg_rt', 'match_8s_accuracy', 'match_8s_avg_rt', 'mismatch_1s_accuracy', 'mismatch_1s_avg_rt', 'mismatch_8s_accuracy', 'mismatch_8s_avg_rt', 'NNonResponses', 'Omissions', 'onesec_accuracy', 'Probe', 'QuinetteAccuracyScore', 'QuinetteProcessingScore', 'response', 'response_time', 'ResponsesGiven', 'Target', 'total_correct', 'total_match_1s_rt', 'total_match_8s_rt', 'total_mismatch_1s_rt', 'total_mismatch_8s_rt', 'total_response_time', 'total_responses', 'width']]
        df_Binding_Task[['acc','average_response_time']] = df_Binding_Task[['acc','average_response_time']].replace(',','.')
        df_Binding_Task = df_Binding_Task.astype({'acc': 'float64','average_response_time': 'float64', 'correct_response': 'str','response':'str'})
        df_Binding_Task = df_Binding_Task.sort_values(by=['subject_nr'], kind='mergesort')
    else:
        df_Binding_Task = df_Binding_Task[['subject_nr','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'acc', 'average_response_time', 'BindingRawScore', 'correct', 'correct_response', 'counter', 'Delay', 'eightsec_accuracy', 'FalseAlarms', 'height', 'Hits', 'live_row', 'logfile', 'match_1s_accuracy', 'match_1s_avg_rt', 'match_8s_accuracy', 'match_8s_avg_rt', 'mismatch_1s_accuracy', 'mismatch_1s_avg_rt', 'mismatch_8s_accuracy', 'mismatch_8s_avg_rt', 'NNonResponses', 'Omissions', 'onesec_accuracy', 'Probe', 'QuinetteAccuracyScore', 'QuinetteProcessingScore', 'response', 'response_time', 'ResponsesGiven', 'Target', 'total_correct', 'total_match_1s_rt', 'total_match_8s_rt', 'total_mismatch_1s_rt', 'total_mismatch_8s_rt', 'total_response_time', 'total_responses', 'width']]
        df_Binding_Task[['acc','average_response_time']] = df_Binding_Task[['acc','average_response_time']].replace(',','.')
        df_Binding_Task = df_Binding_Task.astype({'acc': 'float64','average_response_time': 'float64', 'correct_response': 'str','response':'str'})
        df_Binding_Task = df_Binding_Task.sort_values(by=['subject_nr'], kind='mergesort')

if "Yes" in df_total_part['selMS'].values:
    if df_Multimodal_Span.iloc[0]['selSocDem'] == "Yes":
        df_Multimodal_Span = df_Multimodal_Span[['subject_nr','age','gender','nationality','AttendUniv','HabStudent','HabNonStudent','PreviousDiseases','PreviousDiseasesList','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'keep_track_seq_lenght', 'acc', 'average_response_time_Multimodal', 'calculate_score', 'correct_response', 'height', 'keep_track_errors', 'List_keys_pressed', 'List_Multimodal_button', 'List_Multimodal_Letter', 'List_Multimodal_Pos', 'live_row', 'logfile', 'MultimodalSpanScore', 'pressed_buttons', 'response_time_Multimodal', 'total_correct', 'width']]
        df_Multimodal_Span = df_Multimodal_Span.rename(columns={'correct_response': 'correct'})
        df_Multimodal_Span['acc'] = df_Multimodal_Span['acc'].replace(',','.')
        df_Multimodal_Span = df_Multimodal_Span.astype({'acc': 'float64','correct': 'float64'})
        df_Multimodal_Span = df_Multimodal_Span.sort_values(by=['subject_nr'], kind='mergesort')
    else:
        df_Multimodal_Span = df_Multimodal_Span[['subject_nr','CB_ref', 'CB_ref_process','practice', 'TrialNumber', 'keep_track_seq_lenght', 'acc', 'average_response_time_Multimodal', 'calculate_score', 'correct_response', 'height', 'keep_track_errors', 'List_keys_pressed', 'List_Multimodal_button', 'List_Multimodal_Letter', 'List_Multimodal_Pos', 'live_row', 'logfile', 'MultimodalSpanScore', 'pressed_buttons', 'response_time_Multimodal', 'total_correct', 'width']]
        df_Multimodal_Span = df_Multimodal_Span.rename(columns={'correct_response': 'correct'})
        df_Multimodal_Span['acc'] = df_Multimodal_Span['acc'].replace(',','.')
        df_Multimodal_Span = df_Multimodal_Span.astype({'acc': 'float64','correct': 'float64'})
        df_Multimodal_Span = df_Multimodal_Span.sort_values(by=['subject_nr'], kind='mergesort')

if "Yes" in df_total_part['selSS'].values:
    if df_Symmetry_Span.iloc[0]['selSocDem'] == "Yes":
        df_Symmetry_Span = df_Symmetry_Span[['subject_nr','age','gender','nationality','AttendUniv','HabStudent','HabNonStudent','PreviousDiseases','PreviousDiseasesList','CB_ref', 'CB_ref_process','practice','TrialNumber', 'subblock', 'SubTaskName', 'aggregated_score_memory', 'average_response_time_processing', 'average_total_time_memory', 'correct', 'correct_response', 'countDys','countSym', 'height', 'LeftHalfPos', 'List_SS_button', 'List_SS_Pos', 'live_row', 'logfile', 'maxDys', 'maxSym', 'pressed_buttons', 'response_memory', 'response_processing', 'response_time_memory', 'response_time_processing', 'response_total_time_memory', 'response_total_time_memory_full_task', 'RightHalfPos', 'SP_part_process_time', 'SS_practice_score', 'score_symmetry_span', 'score_subblock_2_1', 'score_subblock_2_2', 'score_subblock_2_3', 'score_subblock_3_1', 'score_subblock_3_2', 'score_subblock_3_3', 'score_subblock_4_1', 'score_subblock_4_2', 'score_subblock_4_3', 'score_subblock_5_1', 'score_subblock_5_2', 'score_subblock_5_3', 'score_subblock_6_1', 'score_subblock_6_2', 'score_subblock_6_3', 'Sub_bloco', 'SymType', 'total_correct_processing', 'total_response_time_processing', 'width']]
        df_Symmetry_Span = df_Symmetry_Span.astype({'correct_response':'str','response_processing':'str','subblock':'str'})
        example_d = df_Symmetry_Span["response_processing"].iloc[2]
        df_Symmetry_Span = df_Symmetry_Span.replace(example_d,'')
        df_Symmetry_Span = df_Symmetry_Span.sort_values(by=['subject_nr'], kind='mergesort')
    else:
        df_Symmetry_Span = df_Symmetry_Span[['subject_nr','CB_ref', 'CB_ref_process','practice','TrialNumber', 'subblock', 'SubTaskName', 'aggregated_score_memory', 'average_response_time_processing', 'average_total_time_memory', 'correct', 'correct_response', 'countDys','countSym', 'height', 'LeftHalfPos', 'List_SS_button', 'List_SS_Pos', 'live_row', 'logfile', 'maxDys', 'maxSym', 'pressed_buttons', 'response_memory', 'response_processing', 'response_time_memory', 'response_time_processing', 'response_total_time_memory', 'response_total_time_memory_full_task', 'RightHalfPos', 'SP_part_process_time', 'SS_practice_score', 'score_symmetry_span', 'score_subblock_2_1', 'score_subblock_2_2', 'score_subblock_2_3', 'score_subblock_3_1', 'score_subblock_3_2', 'score_subblock_3_3', 'score_subblock_4_1', 'score_subblock_4_2', 'score_subblock_4_3', 'score_subblock_5_1', 'score_subblock_5_2', 'score_subblock_5_3', 'score_subblock_6_1', 'score_subblock_6_2', 'score_subblock_6_3', 'Sub_bloco', 'SymType', 'total_correct_processing', 'total_response_time_processing', 'width']]
        df_Symmetry_Span = df_Symmetry_Span.astype({'correct_response':'str','response_processing':'str','subblock':'str'})
        example_d = df_Symmetry_Span["response_processing"].iloc[2]
        df_Symmetry_Span = df_Symmetry_Span.replace(example_d,'')
        df_Symmetry_Span = df_Symmetry_Span.sort_values(by=['subject_nr'], kind='mergesort')

if "Yes" in df_total_part['selUT'].values:
    if df_WMU_Task.iloc[0]['selSocDem'] == "Yes":
        df_WMU_Task = df_WMU_Task[['subject_nr','age','gender','nationality','AttendUniv','HabStudent','HabNonStudent','PreviousDiseases','PreviousDiseasesList','CB_ref', 'CB_ref_process','practice','TrialNumber','correct1','correct2','correct3','correct_response1','correct_response2','correct_response3','digit1','digit2','digit3','height', 'Index_List','live_row', 'logfile','response1','response2','response3','response_time1','responseavgRT','total_correct_trial','TotalRtBlock','toUpdate1_1','toUpdate1_2','toUpdate1_3','toUpdate2_1','toUpdate2_2','toUpdate2_3','WMUExperimentalScore','WMUPracticeScore','width']]
        df_WMU_Task = df_WMU_Task.rename(columns={'response_time1':'response_time'})
        df_WMU_Task = df_WMU_Task.sort_values(by=['subject_nr'], kind='mergesort')
        for i in range(0,len(df_WMU_Task['responseavgRT'])):
            if df_WMU_Task['responseavgRT'].iloc[i] == 0:
                df_WMU_Task['responseavgRT'].iloc[i] = ''
        WMU_cast_lis = ['toUpdate1_1','toUpdate1_2','toUpdate1_3','toUpdate2_1','toUpdate2_2','toUpdate2_3']
        for i in WMU_cast_lis:
            for j in range(0,len(df_WMU_Task[i])):
                if df_WMU_Task[i].iloc[j] > 0:
                    df_WMU_Task[i].iloc[j] = '+' + str(int(df_WMU_Task[i].iloc[j]))
                else:
                    df_WMU_Task[i].iloc[j] = str(int(df_WMU_Task[i].iloc[j]))
    else:
        df_WMU_Task = df_WMU_Task[['subject_nr','CB_ref', 'CB_ref_process','practice','TrialNumber','correct1','correct2','correct3','correct_response1','correct_response2','correct_response3','digit1','digit2','digit3','height', 'Index_List','live_row', 'logfile','response1','response2','response3','response_time1','responseavgRT','total_correct_trial','TotalRtBlock','toUpdate1_1','toUpdate1_2','toUpdate1_3','toUpdate2_1','toUpdate2_2','toUpdate2_3','WMUExperimentalScore','WMUPracticeScore','width']]
        df_WMU_Task = df_WMU_Task.rename(columns={'response_time1':'response_time'})
        df_WMU_Task = df_WMU_Task.sort_values(by=['subject_nr'], kind='mergesort')
        for i in range(0,len(df_WMU_Task['responseavgRT'])):
            if df_WMU_Task['responseavgRT'].iloc[i] == 0:
                df_WMU_Task['responseavgRT'].iloc[i] = ''
        WMU_cast_lis = ['toUpdate1_1','toUpdate1_2','toUpdate1_3','toUpdate2_1','toUpdate2_2','toUpdate2_3']
        for i in WMU_cast_lis:
            for j in range(0,len(df_WMU_Task[i])):
                if df_WMU_Task[i].iloc[j] > 0:
                    df_WMU_Task[i].iloc[j] = '+' + str(int(df_WMU_Task[i].iloc[j]))
                else:
                    df_WMU_Task[i].iloc[j] = str(int(df_WMU_Task[i].iloc[j]))

########################################################################################################################################
###Creates Dataframes that will contain the raw and normalized scores of the participants. The next blocks also calculate some
###descriptive stsatistics.
###Creates the excel sheets with the Raw Scores
df_raw_scores = pd.DataFrame()

###Creates the labels for the columns of the data frame.
if "Yes" in df_total_part['selUT'].values:
    labUT = "Updating Task"
else:
    labUT = float("nan")

if "Yes" in df_total_part['selBT'].values:
    labBT = "Binding Task"
else:
    labBT = float("nan")

if "Yes" in df_total_part['selOS'].values:
    labOS = "Operation Span"
else:
    labOS = float("nan")

if "Yes" in df_total_part['selNB'].values:
    labNB= "N-Back Task"
else:
    labNB = float("nan")

if "Yes" in df_total_part['selMS'].values:
    labMS = "Multimodal Span"
else:
    labMS = float("nan")

if "Yes" in df_total_part['selSS'].values:
    labSS = "Symmetry Span"
else:
    labSS = float("nan")

##creates the columns of the dataframe df_raw_scores.
colnames = [labUT,labBT,labOS,labNB,labMS,labSS]
for i in colnames:
    df_raw_scores[i] = float("nan")
#if "Não" in df_total_part['selRS'].values or "Não" in df_total_part['selUT'].values or "Não" in df_total_part['selBT'].values or "Não" in df_total_part['selOS'].values or "Não" in df_total_part['selNB'].values or "Não" in df_total_part['selMS'].values or "Não" in df_total_part['selSS'].values:
if "Nan" in df_raw_scores.columns:
    df_raw_scores.columns = df_raw_scores.columns.fillna('to_drop')
    df_raw_scores.drop('to_drop', axis = 1, inplace = True)
subj_nr = df_total_part["subject_nr"].unique()
df_raw_scores.insert(0,'subject_nr',subj_nr)

##Inserts the values of each participant in each task (and the socio-demographic information) in the the data_frame df_raw_scores.
if "Yes" in df_total_part['selUT'].values:
    RawUT = list(df_WMU_Task.groupby(['subject_nr'],sort=True)['WMUExperimentalScore'].max())
    df_raw_scores["Updating Task"] = RawUT
if "Yes" in df_total_part['selBT'].values:
    RawBT = list(df_Binding_Task.groupby(['subject_nr'],sort=True)['BindingRawScore'].max())
    df_raw_scores["Binding Task"] = RawBT
if "Yes" in df_total_part['selOS'].values:
    RawOS = list((df_Operation_Span.groupby(['subject_nr'],sort=True)['score_operation_span'].max()*60))
    df_raw_scores["Operation Span"] = RawOS
if "Yes" in df_total_part['selNB'].values:
    RawNB = list(df_N_Back.groupby(['subject_nr'],sort=True)['TotalCorrectTwoBack'].max())
    df_raw_scores["N-Back Task"] = RawNB
if "Yes" in df_total_part['selMS'].values:
    RawMS = list(df_Multimodal_Span.groupby(['subject_nr'],sort=True)['MultimodalSpanScore'].max())
    df_raw_scores["Multimodal Span"] = RawMS
if "Yes" in df_total_part['selSS'].values:
    RawSS = list((df_Symmetry_Span.groupby(['subject_nr'],sort=True)['score_symmetry_span'].max()*60))
    df_raw_scores["Symmetry Span"] = RawSS
if "Yes" in df_total_part['selSocDem'].values:
    ageList = list(df_total_part.groupby(['subject_nr'],sort=True)['age'].unique())
    for i in (0,len(ageList)-1):
        ageList[i] = int(ageList[i])
    df_raw_scores.insert(1, 'Age', ageList)
    genderList = list(df_total_part.groupby(['subject_nr'],sort=True)['gender'].unique())
    for i in (0,len(genderList)-1):
        genderList[i] = str(genderList[i])
        genderList[i] = genderList[i][1:len(genderList[i]) - 1]
        genderList[i] = genderList[i][1:len(genderList[i]) - 1]
    df_raw_scores.insert(2, 'Gender', genderList)
    nationalityList = list(df_total_part.groupby(['subject_nr'],sort=True)['nationality'].unique())
    for i in (0,len(nationalityList)-1):
        nationalityList[i] = str(nationalityList[i])
        nationalityList[i] = nationalityList[i][1:len(nationalityList[i]) - 1]
        nationalityList[i] = nationalityList[i][1:len(nationalityList[i]) - 1]
    df_raw_scores.insert(3, 'Nationality', nationalityList)
    AttendUnivList = list(df_total_part.groupby(['subject_nr'],sort=True)['AttendUniv'].unique())
    for i in (0,len(AttendUnivList)-1):
        AttendUnivList[i] = str(AttendUnivList[i])
        AttendUnivList[i] = AttendUnivList[i][1:len(AttendUnivList[i]) - 1]
        AttendUnivList[i] = AttendUnivList[i][1:len(AttendUnivList[i]) - 1]
    df_raw_scores.insert(4, 'AttendUniv', AttendUnivList)
    HabStudentList = list(df_total_part.groupby(['subject_nr'],sort=True)['HabStudent'].unique())
    for i in (0,len(HabStudentList)-1):
        HabStudentList[i] = str(HabStudentList[i])
        HabStudentList[i] = HabStudentList[i][1:len(HabStudentList[i]) - 1]
        HabStudentList[i] = HabStudentList[i][1:len(HabStudentList[i]) - 1]
    df_raw_scores.insert(5, 'HabStudent', HabStudentList)
    HabNonStudentList = list(df_total_part.groupby(['subject_nr'],sort=True)['HabNonStudent'].unique())
    for i in (0,len(HabNonStudentList)-1):
        HabNonStudentList[i] = str(HabNonStudentList[i])
        HabNonStudentList[i] = HabNonStudentList[i][1:len(HabNonStudentList[i]) - 1]
        HabNonStudentList[i] = HabNonStudentList[i][1:len(HabNonStudentList[i]) - 1]
    df_raw_scores.insert(6, 'HabNonStudent', HabNonStudentList)
    PreviousDiseasesList = list(df_total_part.groupby(['subject_nr'],sort=True)['PreviousDiseases'].unique())
    for i in (0,len(PreviousDiseasesList)-1):
        PreviousDiseasesList[i] = str(PreviousDiseasesList[i])
        PreviousDiseasesList[i] = PreviousDiseasesList[i][1:len(PreviousDiseasesList[i]) - 1]
        PreviousDiseasesList[i] = PreviousDiseasesList[i][1:len(PreviousDiseasesList[i]) - 1]
    df_raw_scores.insert(7, 'PreviousDiseases', PreviousDiseasesList)
    PreviousDiseasesListList = list(df_total_part.groupby(['subject_nr'],sort=True)['PreviousDiseasesList'].unique())
    for i in (0,len(PreviousDiseasesListList)-1):
        PreviousDiseasesListList[i] = str(PreviousDiseasesListList[i])
        PreviousDiseasesListList[i] = PreviousDiseasesListList[i][1:len(PreviousDiseasesListList[i]) - 1]
        PreviousDiseasesListList[i] = PreviousDiseasesListList[i][1:len(PreviousDiseasesListList[i]) - 1]
    df_raw_scores.insert(8, 'PreviousDiseasesList', PreviousDiseasesListList)

########################################################################################################################################
######Creates a Dataframe with socio-demographic informtion and the normalized scores of the participants in each tasks.
df_normalized_scores = df_raw_scores.copy(deep=True)

if "Yes" in df_total_part['selUT'].values:
    df_normalized_scores["Updating Task"] = df_normalized_scores["Updating Task"] / 36
if "Yes" in df_total_part['selBT'].values:
    df_normalized_scores["Binding Task"] = df_normalized_scores["Binding Task"] / 16
if "Yes" in df_total_part['selOS'].values:
    df_normalized_scores["Operation Span"] = df_normalized_scores["Operation Span"] / 60
if "Yes" in df_total_part['selNB'].values:
    df_normalized_scores["N-Back Task"] = df_normalized_scores["N-Back Task"] / 12
if "Yes" in df_total_part['selMS'].values:
    df_normalized_scores["Multimodal Span"] = df_normalized_scores["Multimodal Span"] / 11
if "Yes" in df_total_part['selSS'].values:
    df_normalized_scores["Symmetry Span"] = df_normalized_scores["Symmetry Span"] / 60

########################################################################################################################################
###Creates Dataframes with descriptive statistics, raw scores, and normalized data of the participants.
descrNormalized = df_normalized_scores.describe()
descrNormalized.drop(["subject_nr"],axis=1,inplace=True)

descrRaw = df_raw_scores.describe()
descrRaw.drop(["subject_nr"],axis=1,inplace=True)

#print(descrNormalized)
#if "Yes" in df_total_part['selSocDem'].values:
#    descrNormalized.drop(["PreviousDiseasesList"],axis=1,inplace=True)
#    descrRaw.drop(["PreviousDiseasesList"],axis=1,inplace=True)

###Writes the dataframes created throughout this script on a single excel sheet that holds information regarding all WM task completed
###by the participants. This excel will also include excel sheets with raw scores, normalized socres and descriptive statistics for each
###WM task.
with pd.ExcelWriter('BD_WM_Battery.xlsx') as writer:
    if "Yes" in df_total_part['selUT'].values:
        df_WMU_Task.to_excel(writer, sheet_name='Updating Task', index=False)
    if "Yes" in df_total_part['selBT'].values:
        df_Binding_Task.to_excel(writer, sheet_name='Binding Task', index=False)
    if "Yes" in df_total_part['selOS'].values:
        df_Operation_Span.to_excel(writer, sheet_name='Operation Span', index=False)
    if "Yes" in df_total_part['selNB'].values:
        df_N_Back.to_excel(writer, sheet_name='N-Back Task', index=False)
    if "Yes" in df_total_part['selMS'].values:
        df_Multimodal_Span.to_excel(writer, sheet_name='Multimodal Span', index=False)
    if "Yes" in df_total_part['selSS'].values:
        df_Symmetry_Span.to_excel(writer, sheet_name='Symmetry Span', index=False)
    df_raw_scores.to_excel(writer,sheet_name='Raw Scores', index=False)
    df_normalized_scores.to_excel(writer, sheet_name='Normalized Scores', index=False)
    descrRaw.to_excel(writer,sheet_name='Raw Descriptive',index=True)
    descrNormalized.to_excel(writer,sheet_name='Normalized Descriptive',index=True)