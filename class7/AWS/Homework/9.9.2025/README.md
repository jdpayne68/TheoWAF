#How to spin up an EC2 with a custom script

#1. In the AWS console,click on EC2. Then scroll down to Net & Security and select 'Security Group'.
#2. Click orange button 'Create Security Group' --> 'Inbound rules' and add a rule for ssh and a rule for http
#3. In the drop down menu for Type, scroll down and select 'ssh'. Then from Source, select 'Anywhere-IPv4' and enter "Allow ssh" in the description field.
#4. Then repeat and select 'http' and under source, select 'Anywhere-IPv4'. Enter a comment link "Display web page" or whatever you would like in Description field.
#5. For 'Outbound rules' leave as-is. DO NOT make any changes.
#6. Click on the orange button, 'Create security group'
#7. While still on the EC2 page, scroll up to Instances and click on the orange button, "Create instance"
#8. Enter a name for the instance in under 'Name and tags'
#9. Leave the AMI and Instance type as default --> 'Key pair (login)' click on 'Create new key pair'
#10. Add a name for the key pair, leave the other fields with their default values and click on the orange button, "Create key pair".
#11 Under 'Network settings' go to Firewall (security groups) and from the two options choose 'Select existing security group' and scroll down the SG you made earlier and select it.
#12 Leave 'Configure storage' as-is and scroll down and open 'Advanced Details'.
#13 Scroll all the way down to the bottom of the page to 'User data'.
#14 Using the following link (https://github.com/MookieWAF/bmc4/blob/main/ec2scrpit),go to Theo's script and copy it.
#15 Paste the script into the "User data" field and open note page a paste the script and create a .txt file for the homework deliverable
#16 On the righthand side of the page, review the values in "Summary". If everything is correct, click on the orange button, "Launch instance".
#17 A successful banner will appear at the top the page with a link to the instance. Click on the link.
#18 Copy the Public DNS, open a new browser window, type "http://" and then paste the url and press enter. The webpage should appear.
#19 Take a screen shot of the running web page.

#How to tear down the EC2
#1. Go to EC2 and click on instances
#2. Select the tickbox for the instance that you have running
#3. Under 'Instance state' select "Terminate(delete ) instance from the drop down menu.
#4. Refresh. You should see instance status listed "Terminated"
#5. If you want to you can go back an delete the key pair and SG group but this is not required as AWS doesn't charge for them.