\version "2.22.2"

#(define-markup-command
  (time layout props txt )
  (markup?)
  (interpret-markup layout props (markup #:combine #:roman txt #:draw-line '(0 . -2) )))



timeline = {
  \time 5/4

  s4^\markup\time"0:00"
  s4^\markup\time"0:02"
  s4^\markup\time"0:04"
  s4^\markup\time"0:06"
  s4^\markup\time"0:08"

  \bar "|"

  s4^\markup\time"0:10"
  s4^\markup\time"0:12"
  s4^\markup\time"0:14"
  s4^\markup\time"0:16"
  s4^\markup\time"0:18"

  \bar "|" %\break

  s4^\markup\time"0:20"
  s4^\markup\time"0:22"
  s4^\markup\time"0:24"
  s4^\markup\time"0:26"
  s4^\markup\time"0:28"

  \bar "|"

  s4^\markup\time"0:30"
  s4^\markup\time"0:32"
  s4^\markup\time"0:34"
  s4^\markup\time"0:36"
  s4^\markup\time"0:38"

  \bar "|" %\break

  s4^\markup\time"0:40"
  s4^\markup\time"0:42"
  s4^\markup\time"0:44"
  s4^\markup\time"0:46"
  s4^\markup\time"0:48"

  \bar "|"

  s4^\markup\time"0:50"
  s4^\markup\time"0:52"
  s4^\markup\time"0:54"
  s4^\markup\time"0:56"
  s4^\markup\time"0:58"

  \bar "|" %\break

  s4^\markup\time"1:00"
  s4^\markup\time"1:02"
  s4^\markup\time"1:04"
  s4^\markup\time"1:06"
  s4^\markup\time"1:08"

  \bar "|"

  s4^\markup\time"1:10"
  s4^\markup\time"1:12"
  s4^\markup\time"1:14"
  s4^\markup\time"1:16"
  s4^\markup\time"1:18"

  \bar "|" %\break

  s4^\markup\time"1:20"
  s4^\markup\time"1:22"
  s4^\markup\time"1:24"
  s4^\markup\time"1:26"
  s4^\markup\time"1:28"

  \bar "|"

  s4^\markup\time"1:30"
  s4^\markup\time"1:32"
  s4^\markup\time"1:34"
  s4^\markup\time"1:36"
  s4^\markup\time"1:38"

  \bar "|" %\break

  s4^\markup\time"1:40"
  s4^\markup\time"1:42"
  s4^\markup\time"1:44"
  s4^\markup\time"1:46"
  s4^\markup\time"1:48"

  \bar "|"

  s4^\markup\time"1:50"
  s4^\markup\time"1:52"
  s4^\markup\time"1:54"
  s4^\markup\time"1:56"
  s4^\markup\time"1:58"

  \bar "|" %\break

  s4^\markup\time"2:00"
  s4^\markup\time"2:02"
  s4^\markup\time"2:04"
  s4^\markup\time"2:06"
  s4^\markup\time"2:08"

  \bar "|"

  s4^\markup\time"2:10"
  s4^\markup\time"2:12"
  s4^\markup\time"2:14"
  s4^\markup\time"2:16"
  s4^\markup\time"2:18"

  \bar "|" %\break

  s4^\markup\time"2:20"
  s4^\markup\time"2:22"
  s4^\markup\time"2:24"
  s4^\markup\time"2:26"
  s4^\markup\time"2:28"

  \bar "|"

  s4^\markup\time"2:30"
  s4^\markup\time"2:32"
  s4^\markup\time"2:34"
  s4^\markup\time"2:36"
  s4^\markup\time"2:38"

  \bar "|."
%   
%   s4^\markup\time"2:40"
%   s4^\markup\time"2:42"
%   s4^\markup\time"2:44"
%   s4^\markup\time"2:46"
%   s4^\markup\time"2:48"
%   
%   \bar "|"
%   
%   s4^\markup\time"2:50"
%   s4^\markup\time"2:52"
%   s4^\markup\time"2:54"
%   s4^\markup\time"2:56"
%   s4^\markup\time"2:58"
%   
%   \bar "|."
 
%   s4^\markup\time"3:00"
%   s4^\markup\time"3:02"
%   s4^\markup\time"3:04"
%   s4^\markup\time"3:06"
%   s4^\markup\time"3:08"
% 
%   \bar "|"
% 
%   s4^\markup\time"3:10"
%   s4^\markup\time"3:12"
%   s4^\markup\time"3:14"
%   s4^\markup\time"3:16"
%   s4^\markup\time"3:18"
% 
%   \bar "|"\break
% 
%   s4^\markup\time"3:20"
%   s4^\markup\time"3:22"
%   s4^\markup\time"3:24"
%   s4^\markup\time"3:26"
%   s4^\markup\time"3:28"
% 
%   \bar "|"
% 
%   s4^\markup\time"3:30"
%   s4^\markup\time"3:32"
%   s4^\markup\time"3:34"
%   s4^\markup\time"3:36"
%   s4^\markup\time"3:38"
% 
%   \bar "|"\break
% 
%   s4^\markup\time"3:40"
%   s4^\markup\time"3:42"
%   s4^\markup\time"3:44"
%   s4^\markup\time"3:46"
%   s4^\markup\time"3:48"
% 
%   \bar "|"
% 
%   s4^\markup\time"3:50"
%   s4^\markup\time"3:52"
%   s4^\markup\time"3:54"
%   s4^\markup\time"3:56"
%   s4^\markup\time"3:58"
% 
%   \bar "|"\break
% 
%   s4^\markup\time"4:00"
%   s4^\markup\time"4:02"
%   s4^\markup\time"4:04"
%   s4^\markup\time"4:06"
%   s4^\markup\time"4:08"
% 
%   \bar "|"
% 
%   s4^\markup\time"4:10"
%   s4^\markup\time"4:12"
%   s4^\markup\time"4:14"
%   s4^\markup\time"4:16"
%   s4^\markup\time"4:18"
% 
%   \bar "|"\break
% 
%   s4^\markup\time"4:20"
%   s4^\markup\time"4:22"
%   s4^\markup\time"4:24"
%   s4^\markup\time"4:26"
%   s4^\markup\time"4:28"
% 
%   \bar "|"
% 
%   s4^\markup\time"4:30"
%   s4^\markup\time"4:32"
%   s4^\markup\time"4:34"
%   s4^\markup\time"4:36"
%   s4^\markup\time"4:38"
% 
%   \bar "|"\break
% 
%   s4^\markup\time"4:40"
%   s4^\markup\time"4:42"
%   s4^\markup\time"4:44"
%   s4^\markup\time"4:46"
%   s4^\markup\time"4:48"
% 
%   \bar "|"
% 
%   s4^\markup\time"4:50"
%   s4^\markup\time"4:52"
%   s4^\markup\time"4:54"
%   s4^\markup\time"4:56"
%   s4^\markup\time"4:58"
% 
%   \bar "|" \break
% 
%   s4^\markup\time"5:00"
%   s4^\markup\time"5:02"
%   s4^\markup\time"5:04"
%   s4^\markup\time"5:06"
%   s4^\markup\time"5:08"
% 
%   \bar "|"


}
