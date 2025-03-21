Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FB78F5B
	for <netfs@lists.linux.dev>; Fri, 21 Mar 2025 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527697; cv=none; b=JUFSUn3AQDjS6zrPwSNSRTi6IgkNUqoCK42pCQ0KJ+yum2DEbkqRPoyQ/TIrUtzVlXVkGQN3dpFmqvZem9oo0JR6u4JrsmcikM0HDq0OVCsfyaXwwBExX2ESDBFPNuNJ383uM9oDnqtIWdBZcU4K2Q+8iafg+69wlkvFv7vGNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527697; c=relaxed/simple;
	bh=7EB+XLUj7WAxah0ncVurTZhcT9/+thyh/oFOcciuKRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=N0mlT99Wr5O1xUBlpzUgEpvhgFpktgLVEXVe636ZxdC31ZYqHVOVNjqQ8kSWW0qQpBgrTv/ynicXeMwwwFAPrAyeq7OCGI46EBzCLht5Mug9EKLSbrgetMUkCIvu+s6f+Fn+aixFL4j3b+TelU/ufagHrDmL7y71j1dCA4tCar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpZG7k0X; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpZG7k0X"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so1560834e87.2
        for <netfs@lists.linux.dev>; Thu, 20 Mar 2025 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742527692; x=1743132492; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/1VHqP2pY1nreUUm6WpUhlMBXqnkAhk2/iI8qjStqc=;
        b=JpZG7k0XL3b/3HXIXQEVZ+B4T/Nz2N0mZvhgIT7KqMbc/eXmTwjwANsi4355IhxQgP
         pToxBj76PD/fJOjjbZ8kIEI+/Nrr313OduoCxs5wM8Wrqbc14hQ1KgH/YaFQ1cCnE8oH
         //ACnWcX++nweQ1+q8lRUhc8wdlyrSZxp9rWU4Gd/8XQpkQl0EIaosq/gmknLpRzztVL
         HXfsS59yuCRzMCHsOWHJ6rpj2MMinLaokwxSx7CfsnWPyLI+fGf067ZibT+gBzH3IwJH
         0SZMtOYnnrqnG3iJs1jHn9//J1Ign8/JOQ6gbu+DeagQX2yqA2eO1KZC/xkV3S0jRtF8
         vfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742527692; x=1743132492;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/1VHqP2pY1nreUUm6WpUhlMBXqnkAhk2/iI8qjStqc=;
        b=mJUyWIUajD8cnYs8vzllKZ8dpphW5hZ6cQDOugDLSVCRVP1zJUggEFQ6HLkXbquDjf
         Xrmke+V3gCN0G6tHzgxoh1753bIAOD1V3mer5bsW3adJ833BhqhaMYRfjG2pp/DxjFjd
         Dc2PUlSuA86b2dnhRq1VQcVYDrAr/MAm8N+Gmhe3O/waAgKPxNWE1PGLbxNPwOH8x9mf
         kFk0mpPIRGS3qDDNCBHBdAnEOuuTy/SjwxIt0EyJcpHR1gFzCa4Tkj+S1BIQ/tc/nGbB
         2C5j3SQJgbo2nLglaLK+D2fnjE7xjGCZEGxj16h91j3WNEW/tG/CgH3ZzeCxx9TuTgJB
         qRrA==
X-Gm-Message-State: AOJu0YzNBZ1Mw5tsJ0vtjDa5BkcrPwyZx/XFYwZwXXHHD+hknWEB6mB0
	qFMTBoUJ51TBF6qlwq8s28pVDTa5z6zQb8jTImHV4lHpGnsiJo+pBhnFfICTSkgqJtf1yM9aJ7H
	AW3HnrrAjSj6swrAic/r+CPNCV7DOmQ==
X-Gm-Gg: ASbGncvpUC0fYYwX6EfEpjPT8yjiTkEPQ42qLAfrS+dmAnFmgElMIEvV5csFYcXXCYD
	AJAwmm/sIDl0rlRMqLEANybnV1hKLVREt1CGF3qmqhN3/HunfR1NmyXGXkz683gDDllclFseDZd
	ul9wVVXJyQ2Yw2XmGDDCAygY1/5PHR2VQmaYH8umrYXfWKpRHcXaJgJUSujvA=
X-Google-Smtp-Source: AGHT+IEF6ouerg6OeEOuUYBiqOE05byojgX7xAJ513eHxIIG/2nHbYKY5t3q1qtPyhOmsErZdjJk/1SYcQGiDG1RgmM=
X-Received: by 2002:a05:6512:1103:b0:549:7330:6a5a with SMTP id
 2adb3069b0e04-54ad648f09dmr545113e87.23.1742527691530; Thu, 20 Mar 2025
 20:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH2r5muHk=mUQo_SPk3DdzC7=0VCNiS3fDtotHxYUkT746RP=w@mail.gmail.com>
In-Reply-To: <CAH2r5muHk=mUQo_SPk3DdzC7=0VCNiS3fDtotHxYUkT746RP=w@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 20 Mar 2025 22:27:53 -0500
X-Gm-Features: AQ5f1Jp4O_xFycMeQS_QobF2XVQAOxR8prWmvK6Y7UCLqxUlI9wRdqEFiy5sSc4
Message-ID: <CAH2r5mtKitjzG0jGiS7Z5PCAFiR3EAMP7oi+RNwj-4zvQeyNXA@mail.gmail.com>
Subject: Fwd: xfstest results
To: netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

With the first four netfs patches + 6.14-rc7 running our standard
regression tests to Azure with multichannel, I saw a couple of
unexpected failures.

23dbb8c5ffaf netfs: Fix netfs_unbuffered_read() to return ssize_t
rather than int
78067c2bd7f9 netfs: Fix rolling_buffer_load_from_ra() to not clear mark bits
6be938f6c265 netfs: Call `invalidate_cache` only if implemented
5fb49e95f2c2 netfs: Fix collection of results during pause when
collection offloaded

See:
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/builds/403

Test generic/604
+/mnt/scratch/48: No such file or directory

and also test generic/738

    +/data/xfstests-dev/tests/generic/738: line 31: /mnt/scratch/48:
No such file or directory
    +/data/xfstests-dev/tests/generic/738: line 31: /mnt/scratch/48:
No such file or directory
    +/data/xfstests-dev/tests/generic/738: line 31: /mnt/scratch/48:
No such file or directory
    +/data/xfstests-dev/tests/generic/738: line 31: /mnt/scratch/48:
No such file or directory
    +/data/xfstests-dev/tests/generic/738: line 31: /mnt/scratch/48:
No such file or directory

But with all six current netfs patches (including the two additional below):
68109110fec1 netfs: Fix wait/wake to be consistent about the waitqueue used
4f8443992c8c netfs: Fix the request's work item to not require a ref

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/builds/404

I see a hang early on e.g. in cifs/100 then in cifs/103 (and all
following cifs/105 generic/001 etc).  I don't see anything useful in
/var/log/messages

I don't see anything suspicious in /proc/fs/cifs/DebugData but in
/proc/fs/cifs/Stats I do see it shows a session reconnect, and I do
see a suspicious number of open files (which oddly enough is created
by an earlier test, before the hang cifs/100)

          Open files: 1 total (local), -2 open on server

root@fedora29:~# cat /proc/fs/cifs/open_files
# Version:1
# Format:
# <tree id> <ses id> <persistent fid> <flags> <count> <pid> <uid>
<filename> <mid>
0x5 0x792a00b20000a11 0x56ce090b 0x8001 2 5497 0 big-file 23

I will also try a more general test run to see if I can reproduce
anything useful with those


--
Thanks,

Steve


-- 
Thanks,

Steve
